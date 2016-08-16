include_recipe 'selinux_policy::install'
include_recipe 'augeas::geminstall'
include_recipe 'chef-vault'
gem 'ruby-augeas'
case node['platform']
when 'redhat'
  rhsm_repo 'rhel-7-server-extras-rpms' do
    action :enable
    only_if { node['cockpit']['repo'] == 'rhel-7-server-extras-rpms' }
    only_if { node['cockpit']['configure_repo'] }
  end
  # If Cockpit is installed from RHEL Extras repo, the CentOS Extras repo is only used to install the Kubernetes dashboard
  yum_repository 'centos-extras-cockpit' do
    description 'CentOS 7 Extras Repository configured to provide Cockpit packages only'
    baseurl 'http://mirror.centos.org/centos/7/extras/x86_64'
    gpgkey 'http://mirror.centos.org/centos/RPM-GPG-KEY-CentOS-7'
    action :create
    includepkgs (node['cockpit']['repo'] == 'rhel-7-server-extras-rpms' ? 'cockpit-kubernetes' : 'cockpit*')
    not_if { node['cockpit']['repo'] == 'cockpit-preview' }
    only_if { node['cockpit']['configure_repo'] }
  end
  yum_repository 'group_cockpit-cockpit-preview' do
    description 'Copr repo for cockpit-preview owned by @cockpit'
    baseurl 'https://copr-be.cloud.fedoraproject.org/results/@cockpit/cockpit-preview/epel-7-$basearch/'
    gpgkey 'https://copr-be.cloud.fedoraproject.org/results/@cockpit/cockpit-preview/pubkey.gpg'
    action :create
    only_if { node['cockpit']['repo'] == 'cockpit-preview' }
    only_if { node['cockpit']['configure_repo'] }
  end
  package 'cockpit' do
    version node['cockpit']['version']
  end
  firewalld_service 'cockpit'
  service 'cockpit' do
    action [:enable, :start]
  end
  directory '/etc/systemd/system/cockpit.socket.d'
  execute 'systemctl-daemon-reload' do
    command '/bin/systemctl --system daemon-reload'
    action :nothing
  end
  selinux_policy_port node['cockpit']['port'] do
    protocol 'tcp'
    secontext 'websm_port_t'
  end
  if node['cockpit'].attribute?('ssl_vault') && node['cockpit'].attribute?('ssl_item')
    file '/etc/cockpit/ws-certs.d/0-self-signed.cert' do
      action :delete
    end
    certdata = chef_vault_item(node['cockpit']['ssl_vault'], node['cockpit']['ssl_item'])
    file '/etc/cockpit/ws-certs.d/100-cockpit.cert' do
      content "#{certdata['cert']}\n#{certdata['key']}"
      mode '0440'
      owner 'root'
      group 'cockpit-ws'
      notifies :restart, 'service[cockpit]', :delayed
    end
  end
  template '/etc/systemd/system/cockpit.socket.d/listen.conf' do
    source 'listen.conf.erb'
    notifies :run, 'execute[systemctl-daemon-reload]', :immediately
    notifies :restart, 'service[cockpit]', :delayed
  end
  firewalld_port "#{node['cockpit']['port']}/tcp" do
    action :add
  end
  file '/etc/cockpit/cockpit.conf' do
    action :touch
  end
  augeas 'set LoginTitle for Cockpit' do
    changes [
      "set /files/etc/cockpit/cockpit.conf/WebService/LoginTitle #{node['cockpit']['logintitle']}"]
    lens    'Puppet.lns'
    incl    '/etc/cockpit/cockpit.conf'
    only_if { node['cockpit']['logintitle'] }
    notifies :restart, 'service[cockpit]', :delayed
  end
end

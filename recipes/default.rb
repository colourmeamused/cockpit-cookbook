include_recipe 'selinux_policy::install'
case node['platform']
when 'redhat'
  rhsm_repo 'rhel-7-server-extras-rpms' do
    action :enable
  end
  package 'cockpit'
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
  template '/etc/systemd/system/cockpit.socket.d/listen.conf' do
    source 'listen.conf.erb'
    notifies :run, 'execute[systemctl-daemon-reload]', :immediately
    notifies :restart, 'service[cockpit]', :delayed
  end
  firewalld_port "#{node['cockpit']['port']}/tcp" do
    action :add
  end
end

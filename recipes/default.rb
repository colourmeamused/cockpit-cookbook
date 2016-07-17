

case node['platform']
when 'rhel'
  rhsm_repo 'rhel-7-server-extras-rpms' do
    action :enable
  end

  package 'cockpit'
  firewalld_service 'cockpit'
  service 'cockpit' do
    action [:enable, :start]
  end

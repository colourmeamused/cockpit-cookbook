case node['platform']
when 'redhat'
  rhsm_repo 'rhel-7-server-extras-rpms' do
    action :enable
  end
  package 'cockpit'
  firewalldconfig_service 'cockpit'
  service 'cockpit' do
    action [:enable, :start]
  end
end

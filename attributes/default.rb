default['cockpit']['port'] = 9090
default['cockpit']['version'] = nil
default['cockpit']['logintitle'] = nil
default['cockpit']['features']['pcp'] = false
default['cockpit']['features']['kubernetes'] = false
default['cockpit']['configure_repo'] = true
default['cockpit']['repo'] = 'rhel-7-server-extras-rpms'
default['augeas']['packages'] = %w(augeas augeas-devel ruby-augeas)

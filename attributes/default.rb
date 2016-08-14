default['cockpit']['port'] = 9090
default['cockpit']['version'] = nil
default['cockpit']['logintitle']= nil
default['cockpit']['features']['pcp'] = false
default['cockpit']['features']['kubernetes'] = false
# Configure CentOS Extras repo for cockpit-kubernetes package
default['yum']['extras']['managed'] = true
default['yum']['extras']['repositoryid'] = 'centos-extras'
default['yum']['extras']['enabled'] = false
default['yum']['extras']['mirrorlist'] = nil
default['yum']['extras']['baseurl'] = 'http://mirror.centos.org/centos/7/extras/x86_64'
default['yum']['extras']['gpgkey'] = 'http://mirror.centos.org/centos/RPM-GPG-KEY-CentOS-7'
# Stop the yum-centos cookbook from configuring any other CentOS repos
default['yum']['base']['managed'] = false
default['yum']['updates']['managed'] = false
default['augeas']['packages'] = %w(augeas augeas-devel ruby-augeas)

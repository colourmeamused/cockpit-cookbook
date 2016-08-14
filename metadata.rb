name 'cockpit'
maintainer 'colourmeamused'
maintainer_email '<maintainer> AT outlook com'
license 'apachev2'
description 'Installs/Configures cockpit'
long_description 'Installs/Configures cockpit (cockpit-project.org).
                  Initial support for RHEL 7.x'
version '0.3.0'
source_url 'https://github.com/colourmeamused/cockpit-cookbook.git'
issues_url 'https://github.com/colourmeamused/cockpit-cookbook/issues'
supports 'rhel', '>= 7.1'
depends 'redhat_subscription_manager', '~> 0.5.0'
depends 'firewalld', '~> 1.1.1'
depends 'selinux_policy', '~> 0.9.5'
depends 'augeas'
depends 'yum-centos', '>= 0.4.13'

# Install and configure optional Cockpit features
include_recipe 'yum-centos'
package 'cockpit-kubernetes' do
  options " --enablerepo=#{node['yum']['extras']['repositoryid']} "
  only_if { node['cockpit']['features']['kubernetes'] }
end
package 'cockpit-pcp' do
  only_if { node['cockpit']['features']['pcp'] }
end

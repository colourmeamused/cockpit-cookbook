# Install and configure optional Cockpit features
package 'cockpit-kubernetes' do
  only_if { node['cockpit']['features']['kubernetes'] }
end
package 'cockpit-pcp' do
  only_if { node['cockpit']['features']['pcp'] }
end

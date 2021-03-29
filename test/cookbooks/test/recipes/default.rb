package 'ruby'

node.default['gem_server']['virtual_host_name'] = 'gems.test'

include_recipe 'gems::server'

file "#{node['gem_server']['directory']}/index.html" do
  owner 'root'
  group 'root'
  mode '0644'
  content '<h1>Test Document<h1>'
end

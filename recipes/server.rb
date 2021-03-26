#
# Cookbook:: gems
# Recipe:: server
#
# Copyright:: 2009-2019, Chef Software, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
chef_gem 'builder' do
  action :nothing
  notifies :run, 'execute[index-gem-repository]'
end

service 'apache2' do
  service_name lazy { apache_platform_service_name }
  supports restart: true, status: true, reload: true
  action :nothing
end

apache2_install 'default_install'
apache2_module 'headers'

execute 'index-gem-repository' do
  command "gem generate_index -d #{node['gem_server']['directory']}"
  action :nothing
end

directory node['gem_server']['directory'] do
  owner 'root'
  group 'root'
  mode '0755'
  recursive true
end

remote_directory "#{node['gem_server']['directory']}/gems" do
  source 'packages'
  owner 'root'
  group 'root'
  mode '0755'
  notifies :install, 'chef_gem[builder]'
end

apache2_default_site 'gem_server' do
  default_site_name node['gem_server']['virtual_host_name']
  template_cookbook 'gems'
  template_source 'gem_server.conf.erb'
  docroot_dir node['gem_server']['directory']
  action :enable
  port '80'
end

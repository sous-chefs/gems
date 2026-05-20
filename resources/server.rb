# frozen_string_literal: true

provides :gems_server
unified_mode true

property :server_name, String, name_property: true
property :server_aliases, [String, Array], default: 'gems',
                                           coerce: proc { |aliases| aliases.is_a?(Array) ? aliases : Array(aliases) }
property :server_admin, String, default: 'root@localhost'
property :directory, String, default: '/srv/gems'
property :ruby_package, [String, Array], default: 'ruby'
property :index_gem, String, default: 'rubygems-generate_index'
property :packages_source, String, default: 'packages'
property :packages_cookbook, [String, nil]
property :sync_packages, [true, false], default: true
property :owner, String, default: 'root'
property :group, String, default: 'root'
property :mode, String, default: '0755'
property :site_name, String, default: 'gem_server'

action :create do
  apache2_install 'default'

  package new_resource.ruby_package

  gem_package new_resource.index_gem

  template "#{apache_dir}/sites-available/#{new_resource.site_name}.conf" do
    source 'gem_server.conf.erb'
    cookbook 'gems'
    variables(
      server_admin: new_resource.server_admin,
      virtual_host_name: new_resource.server_name,
      virtual_host_aliases: new_resource.server_aliases,
      gem_directory: new_resource.directory,
      log_dir: default_log_dir
    )
    owner 'root'
    group new_resource.group
    mode '0644'
  end

  apache2_site new_resource.site_name

  execute "index-#{new_resource.site_name}-gem-repository" do
    command "gem generate_index -d #{new_resource.directory}"
    action :nothing
  end

  directory new_resource.directory do
    owner new_resource.owner
    group new_resource.group
    mode new_resource.mode
  end

  remote_directory "#{new_resource.directory}/gems" do
    source new_resource.packages_source
    cookbook new_resource.packages_cookbook if new_resource.packages_cookbook
    owner new_resource.owner
    group new_resource.group
    mode new_resource.mode
    notifies :run, "execute[index-#{new_resource.site_name}-gem-repository]"
    only_if { new_resource.sync_packages }
  end
end

action :delete do
  apache2_site new_resource.site_name do
    action :disable
  end

  template "#{apache_dir}/sites-available/#{new_resource.site_name}.conf" do
    action :delete
  end

  directory new_resource.directory do
    recursive true
    action :delete
  end
end

action_class do
  include Apache2::Cookbook::Helpers
end

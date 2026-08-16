# frozen_string_literal: true

provides :gems_mirror
unified_mode true

property :server_name, String, name_property: true
property :server_aliases, [String, Array], default: 'rubyforge',
                                           coerce: proc { |aliases| aliases.is_a?(Array) ? aliases : Array(aliases) }
property :server_admin, String, default: 'root@localhost'
property :directory, String, default: '/srv/rubyforge'
property :source_url, String, default: 'rsync://master.mirror.rubyforge.org/gems/'
property :ruby_package, [String, Array], default: 'ruby'
property :index_gem, String, default: 'rubygems-generate_index'
property :rsync_package, String, default: 'rsync'
property :owner, String, default: 'root'
property :group, String, default: 'root'
property :mode, String, default: '0755'
property :site_name, String, default: 'rubyforge_mirror'
property :cron_name, String, default: 'mirror_rubyforge'
property :cron_hour, [String, Integer], default: '2'
property :cron_minute, [String, Integer], default: '0'

action :create do
  apache2_install 'default'

  package Array(new_resource.ruby_package) + [new_resource.rsync_package]

  gem_package new_resource.index_gem

  directory new_resource.directory do
    owner new_resource.owner
    group new_resource.group
    mode new_resource.mode
  end

  directory "#{new_resource.directory}/gems" do
    owner new_resource.owner
    group new_resource.group
    mode new_resource.mode
  end

  cron new_resource.cron_name do
    command "rsync -av #{new_resource.source_url} #{new_resource.directory}/gems && gem generate_index -d #{new_resource.directory}"
    hour new_resource.cron_hour.to_s
    minute new_resource.cron_minute.to_s
  end

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
end

action :delete do
  apache2_site new_resource.site_name do
    action :disable
  end

  template "#{apache_dir}/sites-available/#{new_resource.site_name}.conf" do
    action :delete
  end

  cron new_resource.cron_name do
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

name              'gems'
maintainer        'Chef Software, Inc.'
maintainer_email  'cookbooks@chef.io'
license           'Apache 2.0'
description       'Sets up a local gem server repository or mirror'
long_description  IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version           '1.0.2'
recipe            'gems', 'Empty, use one of the other recipes'
recipe            'gems::server', 'Sets up a local gem server repository'
recipe            'gems::mirror', 'Crons an rsync of rubyforge'
depends           'apache2'
depends           'rsync'

%w( ubuntu debian ).each do |os|
  supports os
end

source_url 'https://github.com/chef-cookbooks/gems' if respond_to?(:source_url)
issues_url 'https://github.com/chef-cookbooks/gems/issues' if respond_to?(:issues_url)

attribute 'gem_server',
  display_name: 'Gem Server',
  description: 'Hash of Gem Server attributes',
  type: 'hash'

attribute 'gem_server/virtual_host_name',
  display_name: 'Gem Server Virtual Hostname',
  description: 'Apache ServerName for the virtual host',
  default: 'gems.domain'

attribute 'gem_server/virtual_host_alias',
  display_name: 'Gem Server Virtual Host Aliases',
  description: "Array of Apache ServerAlias'es",
  type: 'array',
  default: 'gems'

attribute 'gem_server/directory',
  display_name: 'Gem Server Directory',
  description: 'Filesystem location of where the gems repository is served from',
  default: '/srv/gems'

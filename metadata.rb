name              'gems'
maintainer        'Chef Software, Inc.'
maintainer_email  'cookbooks@chef.io'
license           'Apache-2.0'
description       'Sets up a local gem server repository or mirror'
long_description  IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version           '2.0.2'
recipe            'gems', 'Empty, use one of the other recipes'
recipe            'gems::server', 'Sets up a local gem server repository'
recipe            'gems::mirror', 'Crons an rsync of rubyforge'
depends           'apache2'
depends           'rsync'

%w( ubuntu debian ).each do |os|
  supports os
end

source_url 'https://github.com/chef-cookbooks/gems'
issues_url 'https://github.com/chef-cookbooks/gems/issues'
chef_version '>= 12.1' if respond_to?(:chef_version)

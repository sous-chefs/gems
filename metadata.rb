name              'gems'
maintainer        'Chef Software, Inc.'
maintainer_email  'cookbooks@chef.io'
license           'Apache-2.0'
description       'Sets up a local gem server repository or mirror'
version           '2.0.7'

depends           'apache2'
depends           'rsync'

supports 'ubuntu'
supports 'debian'

source_url 'https://github.com/chef-cookbooks/gems'
issues_url 'https://github.com/chef-cookbooks/gems/issues'
chef_version '>= 12.15'

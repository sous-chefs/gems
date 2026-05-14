# frozen_string_literal: true

name              'gems'
maintainer        'Sous Chefs'
maintainer_email  'help@sous-chefs.org'
license           'Apache-2.0'
description       'Provides custom resources for local RubyGems repositories and mirrors'
version           '2.0.17'
source_url        'https://github.com/sous-chefs/gems'
issues_url        'https://github.com/sous-chefs/gems/issues'
chef_version      '>= 15.3'

depends           'apache2'
depends           'rsync'

supports 'debian', '>= 12.0'
supports 'ubuntu', '>= 22.04'

default['gem_server']['rf_virtual_host_name']  = "rubyforge.#{domain}"
default['gem_server']['rf_virtual_host_alias'] = "rubyforge"
node.default['gem_server']['rf_directory']="/srv/rubyforge/mirror"

default['gem_server']['mirror__cron_command']="/usr/local/bin/lockrun --lockfile=/srv/mirror.lockrun -- /bb/webops/ruby-2.0.0/embedded/bin/ruby -rrubygems/commands/mirror_command -S /bb/webops/ruby-2.0.0/embedded/bin/gem mirror &>> /srv/mirror.log"
default['gem_server']['mirror_cron_expression']="*/5 * * * *"


node.default['gem_server']['mirrorrc_contents']="---
- from: http://rubygems.org
  to: #{node['gem_server']['rf_directory']}
  parallelism: 100"
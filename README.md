# gems Cookbook

[![Cookbook Version](https://img.shields.io/cookbook/v/gems.svg)](https://supermarket.chef.io/cookbooks/gems)
[![CI State](https://github.com/sous-chefs/gems/workflows/ci/badge.svg)](https://github.com/sous-chefs/gems/actions?query=workflow%3Aci)
[![OpenCollective](https://opencollective.com/sous-chefs/backers/badge.svg)](#backers)
[![OpenCollective](https://opencollective.com/sous-chefs/sponsors/badge.svg)](#sponsors)
[![License](https://img.shields.io/badge/License-Apache%202.0-green.svg)](https://opensource.org/licenses/Apache-2.0)

Sets up a local gem server repository.

## Maintainers

This cookbook is maintained by the Sous Chefs. The Sous Chefs are a community of Chef cookbook maintainers working together to maintain important cookbooks. If you’d like to know more please visit sous-chefs.org or come chat with us on the Chef Community Slack in #sous-chefs.

## Requirements

### Platform

- Ubuntu / Debian

### Cookbooks

- apache2
- rsync

### Chef

- Chef 12.15+

## Attributes

- `gem_server['virtual_host_name']` - ServerName for Apache vhost. Default 'gems.domain'.
- `gem_server['virtual_host_alias']` - ServerAlias(es) for Apache vhost. Default 'gems'.
- `gem_server['directory']` - Filesystem location for the repository, default is /srv/gems.

## Usage

Create files/default/packages, and copy gems to that directory.

Specify the gem source on clients via the command line, for example:

```shell
sudo gem source -a http://gems
sudo gem install rails --source http://gems
```

Or use the source with gem_package resources in your chef recipes.

```ruby
gem_package "rails" do
  source "http://gems"
end
```

Use the gems::mirror recipe to mirror RubyForge. This will take a long time because the repository is 28k+ gems and over 5.5G. It will also override the remote_directory resource to not notify gem generate_index, and instead handle that in the cron job that does the rsync.

## Contributors

This project exists thanks to all the people who [contribute.](https://opencollective.com/sous-chefs/contributors.svg?width=890&button=false)

### Backers

Thank you to all our backers!

![https://opencollective.com/sous-chefs#backers](https://opencollective.com/sous-chefs/backers.svg?width=600&avatarHeight=40)

### Sponsors

Support this project by becoming a sponsor. Your logo will show up here with a link to your website.

![https://opencollective.com/sous-chefs/sponsor/0/website](https://opencollective.com/sous-chefs/sponsor/0/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/1/website](https://opencollective.com/sous-chefs/sponsor/1/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/2/website](https://opencollective.com/sous-chefs/sponsor/2/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/3/website](https://opencollective.com/sous-chefs/sponsor/3/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/4/website](https://opencollective.com/sous-chefs/sponsor/4/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/5/website](https://opencollective.com/sous-chefs/sponsor/5/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/6/website](https://opencollective.com/sous-chefs/sponsor/6/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/7/website](https://opencollective.com/sous-chefs/sponsor/7/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/8/website](https://opencollective.com/sous-chefs/sponsor/8/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/9/website](https://opencollective.com/sous-chefs/sponsor/9/avatar.svg?avatarHeight=100)

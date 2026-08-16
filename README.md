# gems Cookbook

[![Cookbook Version](https://img.shields.io/cookbook/v/gems.svg)](https://supermarket.chef.io/cookbooks/gems)

Provides custom resources for local RubyGems repositories and mirrors.

## Requirements

### Platform

* Debian 12+
* Ubuntu 22.04+

### Cookbooks

* apache2
* rsync

### Chef

* Chef 15.3+

## Resources

* [gems_server](documentation/gems_server.md)
* [gems_mirror](documentation/gems_mirror.md)

## Usage

Declare `gems_server` in a wrapper cookbook recipe. If the wrapper cookbook stores gem packages in
`files/default/packages`, pass that cookbook name with `packages_cookbook`.

```ruby
gems_server 'gems.example.com' do
  server_aliases 'gems'
  packages_cookbook 'my_wrapper'
end
```

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

Use `gems_mirror` to configure an rsync-based mirror job:

```ruby
gems_mirror 'mirror.example.com' do
  source_url 'rsync://mirror.example.com/gems/'
end
```

## Migration

This cookbook no longer provides recipes or node attributes. See [migration.md](migration.md) for
the breaking API changes and replacement resource examples.

## License & Authors

Author:: Joshua Timberman [joshua@chef.io](mailto:joshua@chef.io)

```text
Copyright:: 2009-2015, Chef Software, Inc

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```

# Migration

This release migrates the cookbook from recipes and node attributes to custom resources.

## Removed APIs

The following recipe APIs were removed:

* `gems::default`
* `gems::server`
* `gems::mirror`

The following node attributes were removed:

* `node['gem_server']['virtual_host_name']`
* `node['gem_server']['virtual_host_alias']`
* `node['gem_server']['directory']`
* `node['gem_server']['rf_virtual_host_name']`
* `node['gem_server']['rf_virtual_host_alias']`
* `node['gem_server']['rf_directory']`

## Replacement Resources

Use `gems_server` instead of `gems::server`:

```ruby
gems_server 'gems.example.com' do
  server_aliases 'gems'
  directory '/srv/gems'
  packages_cookbook 'my_wrapper'
end
```

Use `gems_mirror` instead of `gems::mirror`:

```ruby
gems_mirror 'mirror.example.com' do
  server_aliases 'rubyforge'
  directory '/srv/rubyforge'
  source_url 'rsync://mirror.example.com/gems/'
end
```

## Test Cookbook Example

The default Kitchen suite now uses `recipe[test::default]`, which declares `gems_server` directly.
Wrapper cookbooks should do the same in their own recipes.

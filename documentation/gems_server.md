# gems_server

Manages an Apache-backed static RubyGems repository.

## Actions

| Action    | Description                                                                                            |
| --------- | ------------------------------------------------------------------------------------------------------ |
| `:create` | Installs dependencies, writes the Apache site, enables it, and creates the gem repository directories. |
| `:delete` | Disables the Apache site and removes the site file and repository directory.                           |

## Properties

| Property            | Type          | Default                     | Description                                        |
| ------------------- | ------------- | --------------------------- | -------------------------------------------------- |
| `server_name`       | String        | name property               | Apache `ServerName`.                               |
| `server_aliases`    | String, Array | `'gems'`                    | Apache `ServerAlias` values.                       |
| `server_admin`      | String        | `'root@localhost'`          | Apache `ServerAdmin` value.                        |
| `directory`         | String        | `'/srv/gems'`               | RubyGems repository document root.                 |
| `ruby_package`      | String, Array | `'ruby'`                    | Ruby package or packages to install.               |
| `index_gem`         | String        | `'rubygems-generate_index'` | Gem that provides `gem generate_index`.            |
| `packages_source`   | String        | `'packages'`                | Cookbook file source directory used for gem files. |
| `packages_cookbook` | String, nil   | `nil`                       | Cookbook containing the package source directory.  |
| `sync_packages`     | true, false   | `true`                      | Whether to copy gem files with `remote_directory`. |
| `owner`             | String        | `'root'`                    | Repository directory owner.                        |
| `group`             | String        | `'root'`                    | Repository directory group.                        |
| `mode`              | String        | `'0755'`                    | Repository directory mode.                         |
| `site_name`         | String        | `'gem_server'`              | Apache site file and enablement name.              |

## Examples

### Basic server

```ruby
gems_server 'gems.example.com' do
  packages_cookbook 'my_wrapper'
end
```

### Server without cookbook-managed gem files

```ruby
gems_server 'gems.example.com' do
  directory '/srv/rubygems'
  sync_packages false
end
```

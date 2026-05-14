# gems_mirror

Manages an Apache-backed RubyGems mirror directory and rsync cron job.

## Actions

| Action    | Description                                                                                                |
| --------- | ---------------------------------------------------------------------------------------------------------- |
| `:create` | Installs dependencies, creates mirror directories, writes the rsync cron job, and enables the Apache site. |
| `:delete` | Disables the Apache site and removes the site file, cron job, and mirror directory.                        |

## Properties

| Property         | Type            | Default                                       | Description                             |
| ---------------- | --------------- | --------------------------------------------- | --------------------------------------- |
| `server_name`    | String          | name property                                 | Apache `ServerName`.                    |
| `server_aliases` | String, Array   | `'rubyforge'`                                 | Apache `ServerAlias` values.            |
| `server_admin`   | String          | `'root@localhost'`                            | Apache `ServerAdmin` value.             |
| `directory`      | String          | `'/srv/rubyforge'`                            | Mirror document root.                   |
| `source_url`     | String          | `'rsync://master.mirror.rubyforge.org/gems/'` | Rsync source URL.                       |
| `ruby_package`   | String, Array   | `'ruby'`                                      | Ruby package or packages to install.    |
| `index_gem`      | String          | `'rubygems-generate_index'`                   | Gem that provides `gem generate_index`. |
| `rsync_package`  | String          | `'rsync'`                                     | Rsync package to install.               |
| `owner`          | String          | `'root'`                                      | Mirror directory owner.                 |
| `group`          | String          | `'root'`                                      | Mirror directory group.                 |
| `mode`           | String          | `'0755'`                                      | Mirror directory mode.                  |
| `site_name`      | String          | `'rubyforge_mirror'`                          | Apache site file and enablement name.   |
| `cron_name`      | String          | `'mirror_rubyforge'`                          | Cron resource name.                     |
| `cron_hour`      | String, Integer | `'2'`                                         | Cron hour.                              |
| `cron_minute`    | String, Integer | `'0'`                                         | Cron minute.                            |

## Examples

### Mirror from a custom rsync source

```ruby
gems_mirror 'mirror.example.com' do
  source_url 'rsync://mirror.example.com/rubygems/'
  directory '/srv/rubygems-mirror'
end
```

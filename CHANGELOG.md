# gems Cookbook CHANGELOG

This file is used to list changes made in each version of the gems cookbook.

## 2.0.1 (2017-04-26)

- Convert Travis integration testing to kitchen-dokken
- Improve Chefspec output
- Fix file modes to be strings 
- Test with Local Delivery and not Rake
- Move templates out of the default directory since only Chef < 12 requires this

## 2.0.0 (2016-09-16)
- Testing updates
- Require Chef 12.1

## v1.0.2 (2015-10-20)

- Fix a typo in a notification that prevented the cookbook from compling
- Updated the supported Ubuntu released in the readme
- Update test kitchen config to test the server install

## v1.0.1 (2015-10-20)

- Converted readme to MD for rendering on the Supermarket
- Added source_url and issues_url to the metadata
- Added name to the metadata for Chef 12
- Added Berksfile
- Added gitignore file
- Add Test Kitchen config
- Added chefignore file
- Added Chef standard rubocop config
- Added Travis CI testing
- Added Gemfile with the latest testing deps
- Updated testing and contributing docs
- Added maintainers.md and maintainers.toml files
- Added travis and cookbook version badges to the readme
- Resolved Rubocop and Foodcritic warnings
- Updated Opscode -> Chef Software

# gems Cookbook CHANGELOG

This file is used to list changes made in each version of the gems cookbook.

## [2.0.17](https://github.com/sous-chefs/gems/compare/2.0.16...v2.0.17) (2025-10-15)


### Bug Fixes

* **ci:** Update workflows to use release pipeline ([#40](https://github.com/sous-chefs/gems/issues/40)) ([484a56d](https://github.com/sous-chefs/gems/commit/484a56d3f8285112ee3dc568fc2e42a114b3b068))

## 2.0.6 - *2023-03-02*

* Remove delivery folder
* Standardise files with files in sous-chefs/repo-management

## 2.0.5 - *2021-08-31*

* Standardise files with files in sous-chefs/repo-management

## 2.0.4 - *2021-06-01*

* resolved cookstyle error: metadata.rb:11:1 refactor: `ChefStyle/OverlyComplexSupportsDependsMetadata`
* resolved cookstyle error: metadata.rb:17:1 refactor: `ChefModernize/RespondToInMetadata`

## 2.0.3 (2018-05-26)

* Properly mock out the distro in the ChefSpec
* Add a test cookbook to update apt / install ruby
* Use full file modes on directories
* Update the platforms we test on to include new Debian/Ubuntu releases

## 2.0.2 (2017-04-26)

* Add a warning when applying the empty gems default recipe
* Chef 13 attribute fix

## 2.0.1 (2017-04-26)

* Convert Travis integration testing to kitchen-dokken
* Improve Chefspec output
* Fix file modes to be strings
* Test with Local Delivery and not Rake
* Move templates out of the default directory since only Chef < 12 requires this

## 2.0.0 (2016-09-16)

* Testing updates
* Require Chef 12.1

## v1.0.2 (2015-10-20)

* Fix a typo in a notification that prevented the cookbook from compling
* Updated the supported Ubuntu released in the readme
* Update test kitchen config to test the server install

## v1.0.1 (2015-10-20)

* Converted readme to MD for rendering on the Supermarket
* Added source_url and issues_url to the metadata
* Added name to the metadata for Chef 12
* Added Berksfile
* Added gitignore file
* Add Test Kitchen config
* Added chefignore file
* Added Chef standard rubocop config
* Added Travis CI testing
* Added Gemfile with the latest testing deps
* Updated testing and contributing docs
* Added maintainers.md and maintainers.toml files
* Added travis and cookbook version badges to the readme
* Resolved Rubocop and Foodcritic warnings
* Updated Opscode -> Chef Software

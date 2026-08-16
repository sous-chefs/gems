# frozen_string_literal: true

require 'spec_helper'

describe 'gems_server' do
  step_into :gems_server
  platform 'ubuntu', '24.04'

  context 'with default properties' do
    recipe do
      gems_server 'gems.example.test' do
        packages_cookbook 'test'
      end
    end

    it { is_expected.to install_apache2_install('default') }
    it { is_expected.to install_package('ruby') }
    it { is_expected.to install_gem_package('rubygems-generate_index') }
    it { is_expected.to create_directory('/srv/gems').with(owner: 'root', group: 'root', mode: '0755') }

    it do
      is_expected.to create_template('/etc/apache2/sites-available/gem_server.conf')
        .with(cookbook: 'gems', owner: 'root', group: 'root', mode: '0644')
    end

    it { is_expected.to enable_apache2_site('gem_server') }
    it { is_expected.to_not run_execute('index-gem_server-gem-repository') }

    it do
      is_expected.to create_remote_directory('/srv/gems/gems')
        .with(source: 'packages', cookbook: 'test', owner: 'root', group: 'root', mode: '0755')
    end
  end

  context 'with custom properties' do
    recipe do
      gems_server 'rubygems.example.test' do
        server_aliases %w(gems rubygems)
        server_admin 'ops@example.test'
        directory '/srv/rubygems'
        ruby_package %w(ruby ruby-dev)
        index_gem 'custom-indexer'
        packages_source 'gem-packages'
        packages_cookbook 'wrapper'
        site_name 'rubygems'
      end
    end

    it { is_expected.to install_package(%w(ruby ruby-dev)) }
    it { is_expected.to install_gem_package('custom-indexer') }
    it { is_expected.to create_directory('/srv/rubygems') }
    it { is_expected.to create_template('/etc/apache2/sites-available/rubygems.conf') }
    it { is_expected.to enable_apache2_site('rubygems') }
    it { is_expected.to create_remote_directory('/srv/rubygems/gems').with(source: 'gem-packages', cookbook: 'wrapper') }
  end

  context 'with package sync disabled' do
    recipe do
      gems_server 'gems.example.test' do
        sync_packages false
      end
    end

    it { is_expected.to_not create_remote_directory('/srv/gems/gems') }
  end

  context 'delete action' do
    recipe do
      gems_server 'gems.example.test' do
        action :delete
      end
    end

    it { is_expected.to disable_apache2_site('gem_server') }
    it { is_expected.to delete_template('/etc/apache2/sites-available/gem_server.conf') }
    it { is_expected.to delete_directory('/srv/gems').with(recursive: true) }
  end
end

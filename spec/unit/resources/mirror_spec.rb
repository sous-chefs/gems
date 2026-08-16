# frozen_string_literal: true

require 'spec_helper'

describe 'gems_mirror' do
  step_into :gems_mirror
  platform 'ubuntu', '24.04'

  context 'with default properties' do
    recipe do
      gems_mirror 'rubyforge.example.test'
    end

    it { is_expected.to install_apache2_install('default') }
    it { is_expected.to install_package(%w(ruby rsync)) }
    it { is_expected.to install_gem_package('rubygems-generate_index') }
    it { is_expected.to create_directory('/srv/rubyforge') }
    it { is_expected.to create_directory('/srv/rubyforge/gems') }
    it { is_expected.to enable_apache2_site('rubyforge_mirror') }

    it do
      is_expected.to create_cron('mirror_rubyforge')
        .with(command: 'rsync -av rsync://master.mirror.rubyforge.org/gems/ /srv/rubyforge/gems && gem generate_index -d /srv/rubyforge',
              hour: '2',
              minute: '0')
    end
  end

  context 'with custom properties' do
    recipe do
      gems_mirror 'mirror.example.test' do
        server_aliases %w(mirror gems-mirror)
        directory '/srv/mirror'
        source_url 'rsync://example.test/gems/'
        rsync_package 'custom-rsync'
        site_name 'mirror'
        cron_name 'mirror_gems'
        cron_hour 3
        cron_minute 15
      end
    end

    it { is_expected.to install_package(%w(ruby custom-rsync)) }
    it { is_expected.to create_directory('/srv/mirror') }
    it { is_expected.to create_template('/etc/apache2/sites-available/mirror.conf') }
    it { is_expected.to enable_apache2_site('mirror') }
    it { is_expected.to create_cron('mirror_gems').with(command: 'rsync -av rsync://example.test/gems/ /srv/mirror/gems && gem generate_index -d /srv/mirror', hour: '3', minute: '15') }
  end

  context 'delete action' do
    recipe do
      gems_mirror 'rubyforge.example.test' do
        action :delete
      end
    end

    it { is_expected.to disable_apache2_site('rubyforge_mirror') }
    it { is_expected.to delete_template('/etc/apache2/sites-available/rubyforge_mirror.conf') }
    it { is_expected.to delete_cron('mirror_rubyforge') }
    it { is_expected.to delete_directory('/srv/rubyforge').with(recursive: true) }
  end
end

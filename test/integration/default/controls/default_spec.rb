# frozen_string_literal: true

control 'gems-server-01' do
  impact 1.0
  title 'Gem repository directory is created'

  describe directory('/srv/gems') do
    it { should exist }
    its('owner') { should eq 'root' }
    its('group') { should eq 'root' }
    its('mode') { should cmp '0755' }
  end

  describe directory('/srv/gems/gems') do
    it { should exist }
    its('owner') { should eq 'root' }
    its('group') { should eq 'root' }
    its('mode') { should cmp '0755' }
  end
end

control 'gems-server-02' do
  impact 1.0
  title 'Apache gem server virtual host is configured'

  describe file('/etc/apache2/sites-available/gem_server.conf') do
    it { should exist }
    its('content') { should include 'ServerName gems.local' }
    its('content') { should include 'ServerAlias gems' }
    its('content') { should include 'DocumentRoot /srv/gems' }
    its('content') { should include 'Require all granted' }
  end

  describe file('/etc/apache2/sites-enabled/gem_server.conf') do
    it { should be_symlink }
  end
end

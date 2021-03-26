control 'default' do
  describe port('80') do
    it { should be_listening }
  end
  describe port('443') do
    it { should be_listening }
  end
  describe http('http://127.0.0.1', headers: { 'Host' => 'gems.test' }) do
    its('status') { should eq 200 }
    its('headers.Content-Type') { should cmp 'text/html' }
    its('body') { should match /^<h1>Test Document<h1>$/ }
  end
end

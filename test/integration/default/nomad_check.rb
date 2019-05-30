control 'nomad-service' do
  describe service('nomad') do
    it { should be_installed }
    it { should be_enabled }
    it { should be_running }
  end
end

control 'nomad-config' do
  describe file('/etc/nomad.d/client.hcl') do
    it { should exist }
    its('owner') { should eq 'root' }
    its('mode') { should cmp '420' }
  end
end

control 'nomad-port-listening' do
  describe port(4646) do
    it { should be_listening }
    its('processes') {should include 'nomad'}
    its('protocols') { should include('tcp') }
    its('protocols') { should_not include('udp') }
  end
  describe port(4647) do
    it { should be_listening }
    its('processes') {should include 'nomad'}
    its('protocols') { should include('tcp') }
    its('protocols') { should_not include('udp') }
  end
end

control 'nomad-client-driver' do
  describe package('docker') do
    it { should be_installed }
  end
end

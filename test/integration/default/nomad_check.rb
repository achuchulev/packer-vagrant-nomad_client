control 'os-family-version' do
  describe os.family do
    it { should eq 'debian' }
  end
  describe os.release do
    it { should eq '16.04' }
  end
  describe os.name do
    it { should eq 'ubuntu' }
  end
end

control 'nomad' do
  describe file('/usr/bin/nomad') do
    it { should exist }
    it { should be_file }
    it { should_not be_directory }
    it { should be_owned_by 'root' }
    its('mode') { should cmp '00755' }
  end
end

control 'nomad-client-drivers' do
  describe package('docker.io') do
    it { should be_installed }
  end
  describe package('default-jre') do
    it { should be_installed }
  end
end

control 'cfssl' do
  describe file('/usr/local/bin/cfssl') do
    it { should exist }
    its('owner') { should eq 'root' }
    its('mode') { should cmp '493' }
  end
  describe file('/usr/local/bin/cfssl-certinfo') do
    it { should exist }
    its('owner') { should eq 'root' }
    its('mode') { should cmp '493' }
  end
  describe file('/usr/local/bin/cfssljson') do
    it { should exist }
    its('owner') { should eq 'root' }
    its('mode') { should cmp '493' }
  end
end
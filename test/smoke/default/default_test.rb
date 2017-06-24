# # encoding: utf-8

# Inspec test for recipe haproxy::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/
# - Install the package
# - Start service
# - Configure default
# - Configure backend

describe package 'haproxy' do
  it { should be_installed }
end

describe service 'haproxy' do
  it { should be_enabled }
  it { should be_running }
end

# Below tests requirements for assignment
describe port(80) do
  it { should be_listening }
end

describe command("curl -L localhost | grep 'google'") do
  its(:exit_status) { should eq 0 }
end
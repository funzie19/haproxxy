# # encoding: utf-8

# Inspec test for recipe haproxy::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

describe package 'haproxy' do
  it { should be_installed }
end

describe service 'haproxy' do
  it { should be_installed }
  it { should be_enabled }
  it { should be_running }
end

describe port(80) do
  it { should be_listening }
end

describe command("curl -L http://127.0.0.1 | grep 'google'") do
  its(:exit_status) { should eq 0 }
end

describe http('http://127.0.0.1/search?q=test') do
  its('body') { should cmp /google/i }
  its('status') { should_not eq '503'}
end

describe user('haproxy') do
  it { should exist }
  its('group') { should eq 'haproxy' }
end

describe group('haproxy') do
  it { should exist }
end

describe file('/etc/haproxy/haproxy.cfg') do
  it { should exist }
  it { should be_file }
  it { should be_owned_by 'haproxy' }
  it { should be_grouped_into 'haproxy' }
  it { should be_readable.by('owner') }
  it { should be_readable.by('group') }
end

describe file('/etc/sysconfig/haproxy') do
  it { should exist }
  it { should be_file }
  it { should be_owned_by 'haproxy' }
  it { should be_grouped_into 'haproxy' }
  it { should be_readable.by('owner') }
  it { should be_readable.by('group') }
end

describe file('/etc/haproxy/endpoints.conf') do
  it { should exist }
  it { should be_file }
  it { should be_owned_by 'haproxy' }
  it { should be_grouped_into 'haproxy' }
  it { should be_readable.by('owner') }
  it { should be_readable.by('group') }
end

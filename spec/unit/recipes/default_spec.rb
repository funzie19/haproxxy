#
# Cookbook:: haproxy
# Spec:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'haproxy::default' do
  context 'When all attributes are default, on an CentOS 7.3' do
    let(:chef_run) do
      # for a complete list of available platforms and versions see:
      # https://github.com/customink/fauxhai/blob/master/PLATFORMS.md
      runner = ChefSpec::ServerRunner.new(platform: 'centos', version: '7.3.1611')
      runner.converge(described_recipe)
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'checks for custom resource to config' do
      expect(chef_run).to config_haproxy_install('haproxy')
    end

    it 'checks for custom resource to set endpoints' do
      expect(chef_run).to setup_endpoint_haproxy_endpoints('haproxy')
    end
  end
end

context 'Step into install resource' do
  let(:chef_run) do
    ChefSpec::SoloRunner.new(platform: 'centos', version: '7.3.1611', step_into: ['haproxy_install']).converge('haproxy::default')
  end

  it 'install haproxy package' do
    expect(chef_run).to install_package('haproxy')
  end

  it 'start starts haproxy service' do
    expect(chef_run).to start_service('haproxy')
  end

  it 'enables haproxy service' do
    expect(chef_run).to enable_service('haproxy')
  end

  it 'creates haproxy.cfg template' do
    expect(chef_run).to create_template('/etc/haproxy/haproxy.cfg').with(
      user: 'haproxy',
      group: 'haproxy'
    )
  end
end

context 'Step into endpoint resource' do
  let(:chef_run) do
    ChefSpec::SoloRunner.new(platform: 'centos', version: '7.3.1611', step_into: ['haproxy_endpoints']).converge('haproxy::default')
  end

  it 'creates endpoints file template' do
    expect(chef_run).to create_template('/etc/haproxy/endpoints.conf').with(
      user: 'haproxy',
      group: 'haproxy'
    )
  end

  it 'includes endpoints cfs in options file' do
    expect(chef_run).to create_template('/etc/sysconfig/haproxy').with(
      user: 'haproxy',
      group: 'haproxy'
    )
  end
end

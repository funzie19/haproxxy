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

    it 'installs haproxy' do
      expect(chef_run).to install_package 'haproxy'
    end

    it 'enables the haproxy service' do
      expect(chef_run).to enable_service 'haproxy'
    end

    it 'starts the haproxy service' do
      expect(chef_run).to start_service 'haproxy'
    end
  end
end

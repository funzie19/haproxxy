#
# Cookbook:: haproxy
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

# Install haproxy
package 'haproxy'

# Start and enable
service 'haproxy' do
	action [:enable, :start]
end

haproxy_backend 'haproxy' do
	template_source 'endpoints.conf.erb'
	endpoints ({
			'google' => {
				:name => 'google2',
				:listen_ip => '*',
				:listen_port => '80',
				:backend_name => 'google_backend',
				:backends => ({
					'google' => {
						:server_name => 'google2',
						:server_address => 'google.com',
						:server_port => '80',
						:extra_params => 'check'
					},
					'yahoo' => {
						:server_name => 'yahoo',
						:server_address => 'yahoo.com',
						:server_port => '80',
						:extra_params => 'check'	
					}
				})
			},
			'yahoo' => {
				:name => 'yahoo',
				:listen_ip => '*',
				:listen_port => '80',
				:backend_name => 'yahoo_backend',
				:backends => ({
					'google' => {
						:server_name => 'google2',
						:server_address => 'google.com',
						:server_port => '80',
						:extra_params => 'check'
					},
					'yahoo' => {
						:server_name => 'yahoo',
						:server_address => 'yahoo.com',
						:server_port => '80',
						:extra_params => 'check'	
					}
				})
			}
		})
	action :set_backend
end
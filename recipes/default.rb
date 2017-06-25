#
# Cookbook:: haproxy
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

haproxy_install 'haproxy' do
  action [:configure]
end

haproxy_endpoints 'haproxy' do
  template_source 'endpoints.conf.erb'
  options_file_path '/etc/haproxy/endpoints.conf'
  endpoint_list(
    'google' => {
      name: 'google_frontend',
      listen_ip: '*',
      listen_port: '80',
      backend_name: 'google_backend',
      backends: {
        'node0' => {
          server_name: 'google-node0',
          server_address: 'www.google.com',
          server_port: '80',
          extra_params: 'check',
        },
        'node1' => {
          server_name: 'google-node1',
          server_address: 'www.google.com',
          server_port: '80',
          extra_params: 'check',
        },
      },
    }
  )
  action :setup_endpoint
end

service 'haproxy' do
  action [:enable, :start]
  supports restart: true, reload: true, status: true
end

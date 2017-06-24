#
# Cookbook:: haproxy
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

# TODO: The following checks
# - Check config before start
# - Restart after config check
# - Seperate frontend?
# - Restart after install

haproxy_install 'haproxy' do
  action :configure
end

haproxy_endpoints 'haproxy' do
  template_source 'endpoints.conf.erb'
  options_file_path '/etc/haproxy/endpoints.conf'
  endpoint_list(
    'google' => {
      name: 'google2',
      listen_ip: '*',
      listen_port: '80',
      backend_name: 'google_backend',
      backends: {
        'google' => {
          server_name: 'google2',
          server_address: 'google.com',
          server_port: '80',
          extra_params: 'check',
        },
        'yahoo' => {
          server_name: 'yahoo',
          server_address: 'google.com',
          server_port: '80',
          extra_params: 'check',
        },
      },
    }
  )
  action :set_backend
end

haproxy_install 'haproxy' do
  action :restart
end

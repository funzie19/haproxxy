property :endpoint_list, Hash, required: true, default: {}
property :template_source, String, name_property: true
property :options_file_path, String, name_property: true

action :setup_endpoint do
  global_haproxy = resources('service[haproxy]')

  template options_file_path do
    source template_source
    owner 'haproxy'
    group 'haproxy'
    variables(
      endpoints: new_resource.endpoint_list
    )
    cookbook 'haproxy'
  end

  template '/etc/sysconfig/haproxy' do
    source 'options.conf.erb'
    owner 'haproxy'
    group 'haproxy'
    variables(
      options_file_path: new_resource.options_file_path
    )
    cookbook 'haproxy'
    notifies :restart, global_haproxy, :delayed
  end
end

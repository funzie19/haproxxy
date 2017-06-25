property :frontends, Hash, required: true, default: {}
property :backends, Hash, required: true, default: {}
property :template_source, String, name_property: true
property :options_file_path, String, name_property: true

action :setup_endpoint do
  global_haproxy = resources('service[haproxy]')

  template options_file_path do
    source template_source
    owner 'haproxy'
    group 'haproxy'
    variables(
      frontends: new_resource.frontends,
      backends: new_resource.backends
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

property :endpoints, :kind_of => Hash, :required => false, :default => {}

property :template_source, String, name_property: true

property :options_file_path, String, name_property: true

action :set_backend do

	template options_file_path do
		source template_source
		owner 'haproxy'
		group 'haproxy'
		variables( 
			endpoints: new_resource.endpoints
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
	end	
end
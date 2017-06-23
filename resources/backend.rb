property :endpoints, :kind_of => Hash, :required => false, :default => {}
property :template_source, String, name_property: true

action :set_backend do

	template '/etc/haproxy/haproxy.cfg' do
		source template_source
		owner 'haproxy'
		group 'haproxy'
		variables( 
			endpoints: new_resource.endpoints
		)
		cookbook 'haproxy'
	end

	template '/etc/sysconfig/haproxy' do
		source 'options.conf'
		owner 'haproxy'
		group 'haproxy'
		variables( 
			endpoints: new_resource.endpoints
		)
		cookbook 'haproxy'
	end	
end
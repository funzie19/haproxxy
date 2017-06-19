property :backend_hash, :kind_of => Hash, :required => false, :default => {}
property :template_source, String, name_property: true

action :set_backend do

	template '/etc/haproxy/haproxy.cfg' do
		source template_source
		owner 'haproxy'
		group 'haproxy'
		variables( 
			backend_hash: new_resource.backend_hash
		)
		cookbook 'haproxy'
	end
end
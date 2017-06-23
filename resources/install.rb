property :chroot, :kind_of => String, :required => false, :default => '/var/lib/haproxy'
property :pidfile, :kind_of => String, :required => false, :default => '/var/run/haproxy.pid'
property :maxconn, :kind_of => Integer, :required => false, :default => 4000
property :user, :kind_of => String, :required => false, :default => 'haproxy'
property :group, :kind_of => String, :required => false, :default => 'haproxy'
property :mode, :kind_of => String, :required => false, :default => 'http'
property :log, :kind_of => String, :required => false, :default => 'global'
property :retry_count, :kind_of => Integer, :required => false, :default => 3
property :default_maxconn, :kind_of => Integer, :required => false, :default => 3000

action :install do
  package 'haproxy' do
    action :install
  end
end

action :start do
  service 'haproxy' do
    action :start
  end
end

action :configure do
	template '/etc/haproxy/haproxy.cfg' do
	source 'default.conf.erb'
	owner 'haproxy'
	group 'haproxy'
	variables( 
		chroot: new_resource.chroot,
		pidfile: new_resource.pidfile,
		maxconn: new_resource.maxconn,
		user: new_resource.user,
		group: new_resource.group,
		mode: new_resource.mode,
		log: new_resource.log,
		retry_count: new_resource.retries,
		default_maxconn: new_resource.default_maxconn
	)
end	
end
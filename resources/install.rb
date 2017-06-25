property :chroot, String, required: false, default: '/var/lib/haproxy'
property :pidfile, String, required: false, default: '/var/run/haproxy.pid'
property :maxconn, Integer, required: false, default: 4000
property :user, String, required: false, default: 'haproxy'
property :group, String, required: false, default: 'haproxy'
property :mode, String, required: false, default: 'http'
property :log, String, required: false, default: 'global'
property :retry_count, Integer, required: false, default: 3
property :default_maxconn, Integer, required: false, default: 3000

action :configure do
  package 'haproxy' do
    action :install
  end

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

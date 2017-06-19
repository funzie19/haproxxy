property :backend_hash, :kind_of => Hash, :required => false, :default => {}

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
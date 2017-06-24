if defined?(ChefSpec)
  ChefSpec.define_matcher :haproxy_install
  def config_haproxy_install(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:haproxy_install, :configure, resource_name)
  end

  ChefSpec.define_matcher :haproxy_endpoints
  def setup_endpoint_haproxy_endpoints(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:haproxy_endpoints, :setup_endpoint, resource_name)
  end
end

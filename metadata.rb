name 'haproxy'
maintainer 'Joseph Kregloh'
maintainer_email 'joseph@yourcgi.com'
license 'All Rights Reserved'
description 'Installs/Configures haproxy'
long_description 'Installs/Configures haproxy'
version '0.1.0'
supports 'centos'
chef_version '>= 12.1' if respond_to?(:chef_version)
issues_url 'https://github.com/funzie19/haproxy/issues'
source_url 'https://github.com/funzie19/haproxy'

depends 'firewall', '~> 2.6.2'
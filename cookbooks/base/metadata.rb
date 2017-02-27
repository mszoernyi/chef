name 'base'
maintainer 'Benedikt Böhm'
maintainer_email 'bb@xnull.de'
license 'Apache 2.0'
description 'base cookbook'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '1.0.0'

source_url 'https://github.com/zenops-cookbooks/base' if respond_to?(:source_url)
issues_url 'https://github.com/zenops-cookbooks/base/issues' if respond_to?(:issues_url)

supports "debian"
supports "ubuntu"

depends "apt"
depends "build-essential"
depends "chef-client"
depends "chef-sugar"
depends "firewall"
depends "hostmasters"
depends "packages"
depends "ubuntu"

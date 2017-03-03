name 'base'
maintainer 'Benedikt Böhm'
maintainer_email 'bb@xnull.de'
license 'Apache 2.0'
description 'base cookbook'
version '1.0.0'

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

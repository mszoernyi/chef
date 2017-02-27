include_recipe "chef-sugar"
include_recipe "ubuntu" if ubuntu?
include_recipe "apt" if debian?
include_recipe "hostmasters"
include_recipe "chef-client::package"
include_recipe "chef-client::config"
include_recipe "build-essential"
include_recipe "packages"

default_firewall = firewall 'default' do
  action :nothing
  delayed_action :restart
end

# fugly
default_firewall.action(:install) unless File.exist?('/etc/default/ufw-chef.rules')

firewall_rule 'allow world to ssh' do
  port 22
  source '0.0.0.0/0'
  notify_firewall false
end

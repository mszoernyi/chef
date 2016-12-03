chef_server_url 'https://CHEF_SERVER_ADDRESS/organizations/ORG_NAME'

chef_repo_path = File.expand_path("../..", __FILE__)
user_file = File.join(chef_repo_path, ".user")

if File.readable?(user_file)
  node_name File.read(user_file).chomp
else
  node_name %x(whoami).chomp
end

client_key File.join(chef_repo_path, '.chef/client.pem')
syntax_check_cache_path File.join(chef_repo_path, '.chef/syntax_check_cache')
cookbook_path [
  File.join(chef_repo_path, 'berks-cookbooks'),
  File.join(chef_repo_path, 'cookbooks'),
]

if ohai
  ohai.plugin_path << File.join(chef_repo_path, '.chef/ohai/plugins')
end

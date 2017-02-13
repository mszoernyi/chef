chef_server_url 'https://CHEF_SERVER_ADDRESS/organizations/ORG_NAME'

chef_repo_path = File.expand_path("../..", __FILE__)
user_file = File.join(chef_repo_path, ".user")

if File.readable?(user_file)
  node_name File.read(user_file).chomp
else
  node_name %x(whoami).chomp
end

client_key File.join(chef_repo_path, '.chef/client.pem')

verbose_logging false

cache_path File.join(chef_repo_path, '.chef')
client_d_dir File.join(chef_repo_path, '.chef/client.d')
syntax_check_cache_path File.join(chef_repo_path, '.chef/syntax_check_cache')

cookbook_path [
  File.join(chef_repo_path, 'berks-cookbooks'),
  File.join(chef_repo_path, 'cookbooks'),
]

if ohai
  ohai.plugin_path << File.join(chef_repo_path, '.chef/ohai/plugins')

  # let's disable all plugins, except the ones we really
  # need in local/non-root mode:
  #  :LSB,
  #  :OS,
  #  :Passwd,
  #  :Platform,
  ohai.disabled_plugins = [
    :Azure,
    :BlockDevice,
    :C,
    :CPU,
    :Chef,
    :Cloud,
    :CloudV2,
    :Command,
    :DMI,
    :DigitalOcean,
    :Drivers,
    :EC2,
    :Elixir,
    :Erlang,
    :Eucalyptus,
    :Filesystem,
    :Filesystem2,
    :Fips,
    :GCE,
    :Go,
    :Groovy,
    :Hardware,
    :Haskell,
    :Hostname,
    :Hostnamectl,
    :InitPackage,
    :IpScopes,
    :Java,
    :Joyent,
    :Kernel,
    :Keys,
    :Languages,
    :Linode,
    :Lua,
    :Machineid,
    :Mdadm,
    :Memory,
    :Mono,
    :Network,
    :NetworkAddresses,
    :Nodejs,
    :Ohai,
    :OhaiTime,
    :Openstack,
    :PHP,
    :PS,
    :Packages,
    :Perl,
    :Powershell,
    :Python,
    :Rackspace,
    :RootGroup,
    :Ruby,
    :Rust,
    :SSHHostKey,
    :Scala,
    :Sessions,
    :ShardSeed,
    :Shells,
    :Softlayer,
    :Sysconf,
    :SystemProfile,
    :Timezone,
    :Uptime,
    :VMware,
    :Virtualbox,
    :Virtualization,
    :VirtualizationInfo,
    :Zpools,
  ]
end

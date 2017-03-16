git "#{node[:homedir]}/.nvm" do
  repository "https://github.com/creationix/nvm"
  action :sync
end

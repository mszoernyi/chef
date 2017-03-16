remote_file "#{node[:script_path]}/gimme" do
  source "https://raw.githubusercontent.com/travis-ci/gimme/master/gimme"
  mode "0755"
end

version = "1.8rc3"

execute "install-golang-#{version}" do
  command "#{node[:script_path]}/gimme #{version}"
  creates "#{node[:homedir]}/.gimme/versions/go#{version}.#{node[:os]}.amd64/bin/go"
end

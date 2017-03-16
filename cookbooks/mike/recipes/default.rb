include_recipe 'mike::rvm'
include_recipe 'vim'

directory "#{node[:vim][:rcdir]}/swp" do
  mode "0755"
end

remote_directory node[:script_path] do
  source "scripts"
  files_mode "0755"
  mode "0755"
end

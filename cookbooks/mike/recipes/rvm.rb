execute "gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3" do
  not_if { %x(gpg --list-key 409B6B1796C275462A1703113804BB82D39DC0E3 &>/dev/null); $?.exitstatus == 0 }
end

rvm_version = "1.27.0"
ruby_version = "2.2.4"
bundler_version = "1.13.6"

execute "curl -sSL https://get.rvm.io | bash -s #{rvm_version}" do
  not_if { File.read("#{node[:homedir]}/.rvm/VERSION").chomp == rvm_version rescue false }
end

execute "#{node[:homedir]}/.rvm/bin/rvm --default ruby-#{ruby_version}" do
  action :nothing
end

execute "#{node[:homedir]}/.rvm/bin/rvm install ruby-#{ruby_version}" do
  creates "#{node[:homedir]}/.rvm/rubies/ruby-#{ruby_version}"
  notifies :restart, "execute[#{node[:homedir]}/.rvm/bin/rvm --default ruby-#{ruby_version}]", :immediately
end

execute "#{node[:homedir]}/.rvm/bin/rvm ruby-#{ruby_version} do gem install bundler -v #{bundler_version}" do
  creates "#{node[:homedir]}/.rvm/gems/ruby-#{ruby_version}/gems/bundler-#{bundler_version}"
end

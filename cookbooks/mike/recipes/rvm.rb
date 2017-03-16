execute "gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3" do
  not_if do
    %x(gpg --list-key 409B6B1796C275462A1703113804BB82D39DC0E3 &>/dev/null)
    $?.exitstatus.zero?
  end
end

rvm_dir = "#{node[:homedir]}/.rvm"
rvm_version = "1.29.0"
ruby_version = "2.2.6"
bundler_version = "1.14.4"

execute "curl -sSL https://get.rvm.io | bash -s #{rvm_version}" do
  not_if do
    begin
      File.read("#{rvm_dir}/VERSION").chomp == rvm_version
    rescue
      false
    end
  end
end

bash "install ruby-#{ruby_version}" do
  if node[:platform_family] == "mac_os_x"
    code "#{rvm_dir}/bin/rvm install ruby-#{ruby_version} --with-openssl-dir=`brew --prefix openssl`"
  else
    code "#{rvm_dir}/bin/rvm install ruby-#{ruby_version}"
  end
  creates "#{rvm_dir}/rubies/ruby-#{ruby_version}"
end

bash "default ruby-#{ruby_version}" do
  code "source #{rvm_dir}/scripts/rvm; rvm --default ruby-#{ruby_version}"
  not_if do
    begin
      File.readlink("#{rvm_dir}/rubies/default") == "#{rvm_dir}/rubies/ruby-#{ruby_version}"
    rescue
      false
    end
  end
end

execute "#{rvm_dir}/bin/rvm ruby-#{ruby_version} do gem install bundler -v #{bundler_version}" do
  creates "#{rvm_dir}/gems/ruby-#{ruby_version}/gems/bundler-#{bundler_version}"
end

template "#{node[:homedir]}/.rubocop.yml" do
  source "rubocop.yml"
end

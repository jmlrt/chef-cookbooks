#
# Cookbook Name:: myenv
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# Update packages
case node["platform_family"]
when "debian"
  execute "apt-get update" do
    ignore_failure true
    action :nothing
  end
when "rhel"
  execute "yum make-cache" do
    ignore_failure true
    action :nothing
  end
end

# Install some usefull packages
package("vim")
package("nmon")
package("nmap")

# Required for setting encrypted password
package("libshadow-ruby1.8")
package("make")

gem_package "ruby-shadow" do
  action :install
end

# Lock user pi on Raspbian
if system("id pi > /dev/null 2>&1")
  user "pi" do
    action :lock
  end
end

# Create User and Group "jmlrt"
group "jmlrt" do
  action :create
  gid 1025
end

user "jmlrt" do
  action :create
  supports :manage_home => true
  comment "Julien M."
  uid 1025
  gid 1025
  home "/home/jmlrt"
  shell "/bin/bash"
  #password ""
end

# Add User "jmlrt to sudo groups
group "sudo" do
  members "jmlrt"
  action :manage
end

group "wheel" do
  members "jmlrt"
  action :manage
end

# Add jmlrt ssh pubkey
directory "/home/jmlrt/.ssh" do
  owner "jmlrt"
  group "jmlrt"
  mode "0700"
  action :create
end

cookbook_file "/home/jmlrt/.ssh/authorized_keys" do
  owner "jmlrt"
  group "jmlrt"
  mode "0600"
  source "jmailleret-pubkey"
  action :create
end

#
# Cookbook Name:: myenv
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# Update packages list
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

# Create my User and my Group
group [:myenv][:mygroup] do
  action :create
  gid [:myenv][:mygid]
end

user [:myenv][:myuser] do
  action :create
  supports :manage_home => true
  comment [:myenv][:mycomment]
  uid [:myenv][:myuid]
  gid [:myenv][:mygid]
  home "/home/"[:myenv][:myuser]
  shell "/bin/bash"
  password [:myenv][:mypassword]
end

# Add my User to sudo groups
group "sudo" do
  members [:myenv][:myuser]
  action :manage
end

group "wheel" do
  members [:myenv][:myuser]
  action :manage
end

# Add my ssh pubkey
directory "/home/"[:myenv][:myuser]"/.ssh" do
  owner [:myenv][:myuser]
  group [:myenv][:mygroup]
  mode "0700"
  action :create
end

cookbook_file "/home/"[:myenv][:myuser]"/.ssh/authorized_keys" do
  owner [:myenv][:myuser]
  group [:myenv][:mygroup]
  mode "0600"
  source [:myenv][:mypubkey]
  action :create
end

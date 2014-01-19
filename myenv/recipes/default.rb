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
#package("vim")
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
group node["myenv"]["mygroup"] do
  action :create
  gid node["myenv"]["mygid"]
end

user node["myenv"]["myuser"] do
  action :create
  supports :manage_home => true
  comment node["myenv"]["mycomment"]
  uid node["myenv"]["myuid"]
  gid node["myenv"]["mygid"]
  home "/home/#{node["myenv"]["myuser"]}"
  shell "/bin/bash"
  password node["myenv"]["mypassword"]
end

# Add my User to sudo groups

# FIXME
#["sudo", "wheel"].each do |g|
#group g do

group "sudo" do
  members node["myenv"]["myuser"]
  action :manage
end

group "wheel" do
  members node["myenv"]["myuser"]
  action :manage
end

# Add my ssh pubkey
directory "/home/#{node["myenv"]["myuser"]}/.ssh" do
  owner node["myenv"]["myuser"]
  group node["myenv"]["mygroup"]
  mode "0700"
  action :create
end

cookbook_file "/home/#{node["myenv"]["myuser"]}/.ssh/authorized_keys" do
  owner node["myenv"]["myuser"]
  group node["myenv"]["mygroup"]
  mode "0600"
  source node["myenv"][:mypubkey]
  action :create
end

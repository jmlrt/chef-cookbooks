#
# Cookbook Name:: myenv
# Recipe:: default
#
# Copyright 2013, JMLRT
#
# All rights reserved - Do Not Redistribute
#

# Required for setting encrypted password
package "libshadow-ruby1.8"
package "make"

gem_package "ruby-shadow"

# Lock user pi on Raspbian
if system("id pi > /dev/null 2>&1")
  user "pi" do
    action :lock
  end
end

# Create my User and my Group
group node['myuser']['mygroup'] do
  action :create
  gid node['myuser']['mygid']
end

user node['myuser']['myuser'] do
  action :create
  supports :manage_home => true
  comment node['myuser']['mycomment']
  uid node['myuser']['myuid']
  gid node['myuser']['mygid']
  home "/home/#{node['myuser']['myuser']}"
  shell "/bin/bash"
  password node['myuser']['mypassword']
end

# Add my User to sudo groups

["admin", "sudo", "wheel"].each do |g|
  group g do
    members node['myuser']['myuser']
    append true
    action :manage
  end
end

# Add my ssh pubkey
directory "/home/#{node['myuser']['myuser']}/.ssh" do
  owner node['myuser']['myuser']
  group node['myuser']['mygroup']
  mode "0700"
  action :create
end

cookbook_file "/home/#{node['myuser']['myuser']}/.ssh/authorized_keys" do
  owner node['myuser']['myuser']
  group node['myuser']['mygroup']
  mode "0600"
  source node['myuser']['mypubkey']
  action :create
end

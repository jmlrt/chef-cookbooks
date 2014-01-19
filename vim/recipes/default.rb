#
# Cookbook Name:: vim
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# Update packages list on Ubuntu
# Fix a bug for vim install on precise32 vagrant box
if platform?("ubuntu")
  execute "apt-get update"
end

# Install some usefull packages
package "vim"

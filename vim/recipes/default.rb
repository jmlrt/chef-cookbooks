#
# Cookbook Name:: vim
# Recipe:: default
#
# Copyright 2014, JMLRT
#
# All rights reserved - Do Not Redistribute
#

# Update packages list on Ubuntu
# Fix a bug for vim install on precise32 vagrant box
if platform?("ubuntu")
  execute "apt-get update"
end

# Install vim packages
package "vim"

# Set vim as default editor
execute "update-alternatives --set editor /usr/bin/vim.basic"

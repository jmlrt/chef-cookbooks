#
# Cookbook Name:: python26
# Recipe:: default
#
# Copyright 2013, JMLRT
#
# All rights reserved - Do Not Redistribute
#

package "epel-release-5-4" do
  source "http://fr2.rpmfind.net/linux/epel/5/i386/epel-release-5-4.noarch.rpm"
  action :install
end

#
# Cookbook Name:: nmon
# Recipe:: default
#
# Copyright 2014, JMLRT
#
# All rights reserved - Do Not Redistribute
#

# Install nmon package
package "nmon"

# Create nmon log dir
directory node['nmon']['nmondir'] do
  owner "root"
  group "root"
  mode "0755"
  action :create
end

# Add nmon to crontab
template "/etc/cron.daily/nmon" do
  owner "root"
  group "root"
  mode "0755"
  source "cron.daily_nmon.erb"
  action :create
end

#
# Cookbook Name:: mysql
# Recipe:: default
#
# Copyright 2013, JMLRT
#
# All rights reserved - Do Not Redistribute
#
package("mysql-server")
package("mysql-client")

service 'mysql' do
  supports [:status]
  action :start
end

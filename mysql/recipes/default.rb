#
# Cookbook Name:: mysql
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
package("mysql-server")
package("mysql-client")

service 'mysql' do
  supports [:status]
  action :start
end

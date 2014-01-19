#
# Cookbook Name:: nginx
# Recipe:: default
#
# Copyright 2013, JMLRT
#
# All rights reserved - Do Not Redistribute
#

package("nginx")
package("php5-fpm")
package("php5-mysql")

service "nginx" do
  supports [:status]
  action :start
end

file "/usr/share/nginx/www/info.php" do
  owner "pi"
  group "pi"
  mode "0644"
  content "<?php

// Show all information, defaults to INFO_ALL
phpinfo();

?>"
  action :create
end

cookbook_file "/etc/nginx/sites-available/default" do
  source "nginx-sites-available-default"
  owner "root"
  group "root"
  mode "0644"
  notifies :reload, resources(:service => "nginx")
end

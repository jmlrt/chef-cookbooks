#
# Cookbook Name:: iptables
# Recipe:: default
#
# Copyright 2014, JMLRT
#
# All rights reserved - Do Not Redistribute
#

# Install iptables package
package "iptables"

# Flush iptables
execute "iptables -F"

if node['iptables']['status'] == "true"
  node['iptables']['open_ports'].each do |p|
    # Open each port listed in open_ports attribute
    execute "iptables -A INPUT -p tcp --dport #{p} -j ACCEPT"
  end
  # Drop all others ports
  execute "iptables -A INPUT -j DROP"
end

#
# Cookbook Name:: sshd
# Recipe:: default
#
# Copyright 2014, JMLRT
#
# All rights reserved - Do Not Redistribute
#

ruby_block "Disable PermitRootLogin on sshd_config " do
  block do
    fe = Chef::Util::FileEdit.new("/etc/ssh/sshd_config")
    fe.search_file_replace_line("^PermitRootLogin", "PermitRootLogin no")
    fe.write_file
    require 'fileutils'
    FileUtils.mv("/etc/ssh/sshd_config.old",
                 "/etc/ssh/sshd_config.before_permitrootlogin.bak")
  end
end

ruby_block "Permit only allowed users on ssh" do
  block do
    fe = Chef::Util::FileEdit.new("/etc/ssh/sshd_config")
    fe.insert_line_if_no_match("^AllowUsers", "AllowUsers #{node['sshd']['allow_users']}")
    fe.search_file_replace_line("AllowUsers", "AllowUsers #{node['sshd']['allow_users']}")
    fe.write_file
    require 'fileutils'
    FileUtils.mv("/etc/ssh/sshd_config.old",
                 "/etc/ssh/sshd_config.before_allow_users.bak")
  end
end

ruby_block "Disable DNS" do
  block do
    fe = Chef::Util::FileEdit.new("/etc/ssh/sshd_config")
    fe.insert_line_if_no_match("^UseDNS", "UseDNS no")
    fe.search_file_replace_line("^UseDNS", "UseDNS no")
    fe.write_file
    require 'fileutils'
    FileUtils.mv("/etc/ssh/sshd_config.old",
                 "/etc/ssh/sshd_config.before_usedns.bak")
  end
end

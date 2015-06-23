#
# Cookbook Name:: mypypi
# Recipe:: pip
#
# Copyright (C) 2015 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe "python"

file "/etc/pip.conf" do
  action :delete
end

template "/etc/pip.conf" do
  source "pip/pip_conf.erb"
  mode '0644'
  owner 'root'
  group 'root'
  variables({
     :fallback_url => node['nginxserver']['fallback_url'],
     :server_name => node['nginxserver']['name'],
     :htuser => node['nginxserver']['htname'],
     :htpassword => node['nginxserver']['htpassword']
  })
end

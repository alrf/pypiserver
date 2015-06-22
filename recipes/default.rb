#
# Cookbook Name:: mypypi
# Recipe:: default
#
# Copyright (C) 2015 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe "python"
include_recipe "nginx"

user node['pypiserver']['user']

venv = node['pypiserver']['virtualenv']

directory node['pypiserver']['storage'] do
  owner node['pypiserver']['user']
  group node['pypiserver']['group']
  mode 0775
  recursive true
end

if venv
  directory node['pypiserver']['virtualenv'] do
    owner node['pypiserver']['user']
    group node['pypiserver']['group']
    recursive true
  end

  python_virtualenv venv do
    owner node['pypiserver']['user']
    group node['pypiserver']['group']
    interpreter node['pypiserver']['python_version']
    action :create
  end
end

eggs = {  "pypiserver" => node['pypiserver']['version'],
          "passlib" => "" }

eggs.each do |pkg,ver|
  python_pip pkg do
    virtualenv venv if venv && venv.length > 0
    version ver if ver && ver.length > 0
    action :install
  end
end

template "/etc/systemd/system/pypiserver.service" do
  source "pypiserver_service.erb"
  mode '0644'
  owner 'root'
  group 'root'
  variables({
     :pypiserver_interface => node['pypiserver']['address'],
     :pypiserver_port => node['pypiserver']['port'],
     :pypiserver_path => node['pypiserver']['virtualenv'],
     :pypiserver_user => node['pypiserver']['user'],
     :pypiserver_group => node['pypiserver']['group'],
     :pypiserver_storage => node['pypiserver']['storage']
  })
end

service "pypiserver" do
  supports :restart => true
  action [ :enable, :start ]
end



#
# Nginx part
#

htpasswd node['nginxserver']['htpasswdfile'] do
  user node['nginxserver']['htname']
  password node['nginxserver']['htpassword']
end

cert = ssl_certificate node['nginxserver']['vhost'] do
  notifies :restart, 'service[nginx]'
end

template File.join(node['nginx']['dir'], 'sites-available', node['nginxserver']['vhost']) do
  source 'nginx_vhost.erb'
  mode 00644
  owner 'root'
  group 'root'
  variables({
    :name => node['nginxserver']['vhost'],
    :server_name => node['nginxserver']['name'],
    :ssl_key => cert.key_path,
    :ssl_cert => cert.chain_combined_path,
    :pypiserver_interface => node['pypiserver']['address'],
    :pypiserver_port => node['pypiserver']['port'],
    :htpasswd => node['nginxserver']['htpasswdfile']
  })
  notifies :reload, 'service[nginx]'
end

# Enable the virtualhost
nginx_site node['nginxserver']['vhost'] do
  enable true
end

# publish the certificate to an attribute, it may be useful
# node.set['web-app']['ssl_cert']['content'] = cert.cert_content

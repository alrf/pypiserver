#
# Cookbook Name:: mypypi
# Recipe:: put_package_into_pypi
#
# Copyright (C) 2015 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#

rfile = 'https://pypi.python.org/packages/py2.py3/D/Django/Django-1.8.2-py2.py3-none-any.whl'

remote_file rfile do
  source rfile
  path node['pypiserver']['storage'] + '/Django-1.8.2-py2.py3-none-any.whl'
  mode '0644'
  owner 'root'
  group 'root'
end

hostsfile_entry '127.0.0.1' do
  hostname node['nginxserver']['name']
  comment 'Append by Chef'
  action :append
end

execute "pip -v install django" do
  command "pip -v install django"
  action :run
end

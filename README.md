Description
===========
This cookbook installs and configures pypiserver, pip and nginx.

Requirements
===========
This cookbook depends on the following Opscode cookbooks:

`python`
`nginx`
`ssl_certificate`
`htpasswd`

Attributes
===========

`version` - the version of pypiserver to install (defaults to 1.1.7)
`storage` - the directory path where python modules should be stored (defaults to /opt/pypi-server/packages)
`user` - the user to run pypiserver under (defaults to root)
`group` - the group to run pypiserver under (defaults to root)
`python_version` - the version of python interpreter to use for the virtualenv (defaults to python2.7)
`virtualenv` - the directory path where a virtualenv for the pypiserver should be created (optional, defaults to `/opt/pypi-server/env)
`address` - the ip address to bind the pypiserver (defaults to 0.0.0.0)
`port` - the port to bind the pypiserver (defaults to 8080)
`fallback_url` - the pypi server to query when this doesn't know about a package (defaults to 'https://pypi.python.org/simple')
`vhost` - Nginx virtualhost name
`name` - Nginx server name
`htpasswdfile` - full path to the htpasswdfile (this file will be create automatically with user and password)
`htname` - user for htpasswdfile
`htpassword` - password for htpasswdfile

Usage
===========

`run_list: ["recipe[mypypi]"]` - default recipe install pypiserver + nginx (with SSL and http_basic auth.) as frontend
`run_list: ["recipe[mypypi::pip_conf]"]` - recipe configure pip.conf

kitchen.yml file included.

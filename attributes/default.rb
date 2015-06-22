default['pypiserver']['version'] = '1.1.7'
default['pypiserver']['storage'] = '/opt/pypi-server/packages'
default['pypiserver']['virtualenv'] = '/opt/pypi-server/env'
default['pypiserver']['user'] = 'root'
default['pypiserver']['group'] = 'root' #FIXME use value_for_platform
default['pypiserver']['python_version'] = 'python2.7'
default['pypiserver']['address'] = "0.0.0.0"
default['pypiserver']['port'] = 8080
default['pypiserver']['passwd_file'] = nil
#default['pypiserver']['fallback_url'] = 'https://pypi.python.org/simple'

default['nginxserver']['vhost'] = 'default'
default['nginxserver']['name'] = 'my.pypi.com'
default['nginxserver']['fallback_url'] = 'https://' + default['nginxserver']['name'] + '/simple'
default['nginxserver']['htpasswdfile'] = '/etc/nginx/htpassword'
default['nginxserver']['htname'] = 'foo'
default['nginxserver']['htpassword'] = 'bar'

case node['platform']
when 'ubuntu'
  #http://opscode-omnibus-packages.s3.amazonaws.com/ubuntu/12.04/x86_64/chef-server_11.0.12-1.ubuntu.12.04_amd64.deb
  #http://opscode-omnibus-packages.s3.amazonaws.com/ubuntu/12.04/x86_64/chef-server_11.1.6-1_amd64.deb
  default['chef11server']['os'] = "ubuntu"
  default['chef11server']['osversion'] = "12.04"
  default['chef11server']['version'] = "_11.0.12-1.ubuntu.12.04_amd64"
  default['chef11server']['package'] = "deb"
when 'centos'
  #http://opscode-omnibus-packages.s3.amazonaws.com/el/5/x86_64/chef-server-11.0.12-1.el5.x86_64.rpm
  default['chef11server']['os'] = "el"
  default['chef11server']['osversion'] = "5"
  default['chef11server']['version'] = "-11.0.12-1.el5.x86_64"
  default['chef11server']['package'] = "rpm"
end

default['chef11server']['filename'] = "chef-server#{node['chef11server']['version']}.#{node['chef11server']['package']}"
default['chef11server']['hostname'] = "http://opscode-omnibus-packages.s3.amazonaws.com"
default['chef11server']['path'] = "#{node['chef11server']['os']}/#{node['chef11server']['osversion']}/x86_64/"
default['chef11server']['download'] = "#{node['chef11server']['hostname']}/#{node['chef11server']['path']}#{node['chef11server']['filename']}"

default['chef11server']['bootstrap'] = true
default['chef11server']['notification_email'] = "support@getuhost.org"
default['chef11server']['topology'] = "standalone"
default['chef11server']['erchef']['s3_url_ttl'] = 3600

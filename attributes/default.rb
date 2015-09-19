case node['platform']
when 'ubuntu'
  default['chef11server']['download'] = "https://web-dl.packagecloud.io/chef/stable/packages/ubuntu/precise/chef-server_11.1.6-1_amd64.deb"
  default['chef11server']['filename'] = "chef-server_11.1.6-1_amd64.deb"
when 'centos'
  default['chef11server']['download'] = "https://web-dl.packagecloud.io/chef/stable/packages/el/6/chef-server-11.1.6-1.el6.x86_64.rpm"
  default['chef11server']['filename'] = "chef-server-11.1.6-1.el6.x86_64.rpm"
end

default['chef11server']['bootstrap'] = true
default['chef11server']['notification_email'] = "support@getuhost.org"
default['chef11server']['topology'] = "standalone"
default['chef11server']['erchef']['s3_url_ttl'] = 3600

default['chef11server']['nginx']['certificate'] = "uhost.getuhost.org"

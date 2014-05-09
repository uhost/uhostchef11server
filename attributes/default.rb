#https://opscode-omnibus-packages.s3.amazonaws.com/ubuntu/12.04/x86_64/chef-server_11.0.12-1.ubuntu.12.04_amd64.deb
default[:chef11server][:os] = "ubuntu"
default[:chef11server][:osversion] = "12.04"
default[:chef11server][:version] = "11.0.12-1"
default[:chef11server][:arch] = "amd64"
default[:chef11server][:download] = "https://opscode-omnibus-packages.s3.amazonaws.com/#{node[:chef11server][:os]}/#{node[:chef11server][:osversion]}/x86_64/chef-server_#{node[:chef11server][:version]}.ubuntu.12.04_amd64.deb"

#https://opscode-omnibus-packages.s3.amazonaws.com/el/5/x86_64/chef-server-11.0.12-1.el5.x86_64.rpm

default[:chef11server][:bootstrap] = true
default[:chef11server][:notification_email] = "info@example.com"
default[:chef11server][:topology] = "standalone"
default[:chef11server][:erchef][:s3_url_ttl] = 3600

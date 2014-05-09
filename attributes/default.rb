#https://opscode-omnibus-packages.s3.amazonaws.com/ubuntu/12.04/x86_64/chef-server_11.0.12-1.ubuntu.12.04_amd64.deb
default[:chef11][:os] = "ubuntu"
default[:chef11][:osversion] = "12.04"
default[:chef11][:version] = "11.0.12-1"
default[:chef11][:arch] = "amd64"
default[:chef11][:download] = "https://opscode-omnibus-packages.s3.amazonaws.com/#{node[:chef11][:os]}/#{node[:chef11][:osversion]}/x86_64/chef-server_#{node[:chef11][:version]}.ubuntu.12.04_amd64.deb"

#https://opscode-omnibus-packages.s3.amazonaws.com/el/5/x86_64/chef-server-11.0.12-1.el5.x86_64.rpm

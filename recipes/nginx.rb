#
# Cookbook Name:: uhostserver
# Recipe:: nginx
#
# Copyright 2014 Mark C. Allen
#
#    Licensed under the Apache License, Version 2.0 (the "License"); you may
#    not use this file except in compliance with the License. You may obtain
#    a copy of the License at
#
#         http://www.apache.org/licenses/LICENSE-2.0
#
#    Unless required by applicable law or agreed to in writing, software
#    distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
#    WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
#    License for the specific language governing permissions and limitations
#    under the License.
#

bash "disable-chef-server-nginx" do
  code <<-EOH
    /usr/bin/chef-server-ctl stop nginx
    rm -f /opt/chef-server/service/nginx
  EOH
  only_if { File.exists?("/opt/chef-server/service/nginx") }
end

include_recipe "nginx"

servername = Chef::Config[:node_name]
sitename = "chef." + servername

hostsfile_entry node[:ipaddress] do
  hostname  sitename
  action    :append
end

hosts = Array.new
hosts.push sitename

template "/etc/nginx/sites-available/"+sitename+".conf" do
  source "chefserver-nginx-http.erb"
  mode 0644
  owner "root"
  group "root"
  variables({
    :servername => servername,
    :host => hosts
  })
end

template "/etc/nginx/sites-available/ssl-"+sitename+".conf" do
  source "chefserver-nginx-https.erb"
  mode 0644
  owner "root"
  group "root"
  variables({
    :servername => servername,
    :host => hosts
  })
end

link "/etc/nginx/sites-enabled/"+sitename+".conf" do
  to "/etc/nginx/sites-available/"+sitename+".conf"
end

link "/etc/nginx/sites-enabled/ssl-"+sitename+".conf" do
  to "/etc/nginx/sites-available/ssl-"+sitename+".conf"
  notifies  :restart, "service[nginx]", :immediately
end



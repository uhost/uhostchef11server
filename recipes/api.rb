#
# Cookbook Name:: uhostserver
# Recipe:: api
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

package "git"

service "uhostappserver" do
  action :stop
  only_if { File.exists?("/etc/init/uhostappserver.conf") }
end

directory "/srv/uhostappserver" do
  recursive true
  action :create
end

deploy_revision "/srv/uhostappserver" do
  migrate false
  repo "https://github.com/uhost/uhostappserver.git"
  symlink_before_migrate.clear
  create_dirs_before_symlink.clear
  purge_before_symlink.clear
  symlinks.clear
  user "uhost"
  group "uhost"
  action :deploy
end

# only needed for ubuntu, not for centos
#if platform?("ubuntu")
#  package "python-software-properties"
#
#  apt_repository 'nodejs' do
#    uri          'ppa:chris-lea/node.js'
#    distribution node['lsb']['codename']
#  end
#end

#package "nodejs"
#package "mongodb"

include_recipe "nodejs"
include_recipe "mongodb"

execute 'npm install' do
  cwd "/srv/uhostappserver/current"
  user "uhost"
  group "uhost"
  environment ({ 'HOME' => "/srv/uhostappserver/shared", 'NODE_ENV' => "prod" })
end

template "uhostappserver.upstart.conf" do
  path "/etc/init/uhostappserver.conf"
  source "uhostappserver.conf.erb"
  owner "root"
  group "root"
  mode "0644"
end

service "uhostappserver" do
  provider Chef::Provider::Service::Upstart
  supports :status => true, :restart => true, :reload => true
  action [:start, :enable]
end

servername = Chef::Config[:node_name]
sitename = servername

hosts = Array.new
hosts.push sitename

template "/etc/nginx/sites-available/"+sitename+".conf" do
  source "uhostappserver-nginx-http.erb"
  mode 0644
  owner "root"
  group "root"
  variables({
    :servername => servername,
    :host => hosts
  })
end

template "/etc/nginx/sites-available/ssl-"+sitename+".conf" do
  source "uhostappserver-nginx-https.erb"
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

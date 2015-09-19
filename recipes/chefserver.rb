#
# Cookbook Name:: uhostserver
# Recipe:: chefserver
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

servername = Chef::Config[:node_name]
sitename = "chef." + servername

remote_file "#{Chef::Config["file_cache_path"]}/#{node["chef11server"]["filename"]}" do
  source node["chef11server"]["download"]
  mode 0644
  not_if { File.exists?("#{Chef::Config["file_cache_path"]}/#{ node["chef11server"]["filename"] }") }
end

case node['platform']
when 'ubuntu'
  packageprovider = Chef::Provider::Package::Dpkg
when 'centos'
  packageprovider = Chef::Provider::Package::Rpm
end

package "install chef11-server" do
  source "#{Chef::Config[:file_cache_path]}/#{node['chef11server']['filename']}"
  provider packageprovider
  action :install
end

directory "/etc/chef-server" do
  owner "root"
  group "root"
  recursive true
end

template "/etc/chef-server/chef-server.rb" do
  source "chef-server-rb.erb"
  mode 0644
  owner "root"
  group "root"
  variables({
    :sitename => sitename
  })
end

bash "reconfigure chef11-server" do
  code <<-EOH
    export http_proxy=""
    export https_proxy=""
    chef-server-ctl reconfigure
  EOH
end

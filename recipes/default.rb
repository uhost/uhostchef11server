#
# Cookbook Name:: uhostserver
# Recipe:: default
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

log "Installing chef server on: " + Chef::Config[:node_name]

include_recipe "apt"

servername = Chef::Config[:node_name]

bash "configure-hostname" do
  code <<-EOH
    /bin/hostname -F /etc/hostname
  EOH
  action :nothing
end

file "/etc/hostname" do
  content servername
  notifies :run, "bash[configure-hostname]", :immediately
end

hostsfile_entry node['ipaddress'] do
  hostname  servername
  action    :append
end

# Reload ohai so that the fqdn is not set correctly
ohai "reload" do
  action :reload
end

include_recipe "uhostchef11server::chefserver"
include_recipe "uhostchef11server::nginx"
include_recipe "uhostchef11server::uhostadmin"
include_recipe "uhostchef11server::users"


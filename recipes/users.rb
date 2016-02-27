#
# Cookbook Name:: uhostserver
# Recipe:: users
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

if platform?("ubuntu") && node['platform_version'].to_f > 14.0
  package "ruby-shadow"
else 
  gem_package "ruby-shadow"
end

include_recipe "users"

users_manage "uhost" do
  group_id 1171
  action [:remove, :create]
end


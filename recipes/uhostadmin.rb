#
# Cookbook Name:: uhostserver
# Recipe:: uhostadmin
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

package "openssl"

servername = Chef::Config[:node_name]
sitename = "chef." + servername

# Wait for erchef to be running
ruby_block "wait_for_erchef" do
  block do
    require "net/http"
    def url_exist?(url_string)
      url = URI.parse(url_string)
      req = Net::HTTP.new(url.host, url.port, nil, nil, nil, nil)
      req.use_ssl = (url.scheme == 'https')
      req.verify_mode = OpenSSL::SSL::VERIFY_NONE
      res = req.request_head(url.path)
      res.code != "502" # false if returns 502
    rescue Errno::ENOENT
      false # false if can't find the server
    end

    ctr = 0

    begin
      res = url_exist?("https://#{sitename}/_status")
      ctr += 1
      if (! res)
        sleep(1)
      end
      if (ctr > 100)
        res = true
        #TODO: throw error
      end
    end while !res
  end
end

template "/etc/chef-server/admin-knife.rb" do
  source "knife-rb.erb"
  mode 0644
  owner "root"
  group "root"
  variables({
    :username => "admin",
    :pemfile => "admin.pem",
    :sitename => sitename
  })
end

bash "delete-admin" do
  code <<-EOH
    export http_proxy=""
    export https_proxy=""
    cd /etc/chef-server
    knife user delete admin -c admin-knife.rb -y
  EOH
  action :nothing
end

bash "create-uhostadmin" do
  code <<-EOH
    export http_proxy=""
    export https_proxy=""
    cd /etc/chef-server
    openssl rand -base64 12 > uhostadmin.txt
    chmod 600 uhostadmin.txt
    knife user create uhostadmin -a -c admin-knife.rb -p `cat uhostadmin.txt` -f /etc/chef-server/uhostadmin.pem -d
    chmod 600 /etc/chef-server/uhostadmin.pem
  EOH
  notifies :run, "bash[delete-admin]", :immediately
  not_if { File.exists?("/etc/chef-server/uhostadmin.pem") }
end


#
# Cookbook Name:: apache2
# Recipe:: default 
#
# Author:: Ryuzee <ryuzee@gmail.com>
#
# Copyright 2013, Ryutaro YOSHIBA 
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in wrhiting, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

if node["platform"] == "centos" and node["platform_version"][0] == "5" 
  include_recipe "yum::remi"
end

case node["platform"]
when "centos", "redhat", "amazon", "scientific", "fedora"

  %w{httpd}.each do |package_name|
    package package_name do
      action :install
    end
  end

  file "/etc/httpd/conf.d/welcome.conf" do
    action :delete
  end

  file "/var/www/html/index.html" do
    action :create_if_missing
    content "It works!"
  end

  service "httpd" do
    supports :restart => true, :reload => true, :status => true
    action [:enable, :start]
    not_if do File.exists?("/var/run/httpd.pid") end
  end

end

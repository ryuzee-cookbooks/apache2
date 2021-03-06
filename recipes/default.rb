#
# Cookbook Name:: apache2
# Recipe:: default 
#
# Author:: Ryuzee <ryuzee@gmail.com>
#
# Copyright 2013, Ryutaro YOSHIBA 
#
# This software is released under the MIT License.
# http://opensource.org/licenses/mit-license.php

if node["platform"] == "centos" and node["platform_version"][0] == "5" 
  yum_repository 'remi' do
    description 'Les RPM de Remi - Repository'
    baseurl 'http://rpms.famillecollet.com/enterprise/5/remi/$basearch/'
    gpgkey 'http://rpms.famillecollet.com/RPM-GPG-KEY-remi'
    fastestmirror_enabled true
    action :create
  end
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
  end

  directory "/var/www/" do
    recursive true
    owner "apache"
    group "apache"
    mode 0775
    action :create
  end

when "ubuntu","debian"

  %w{apache2}.each do |package_name|
    package package_name do
      action :install
    end
  end

  service "apache2" do
    supports :restart => true, :reload => true, :status => true
    action [:enable, :start]
  end

end

# vim: filetype=ruby.chef

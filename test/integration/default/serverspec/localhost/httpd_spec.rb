require 'serverspec'
include Serverspec::Helper::Exec
include Serverspec::Helper::DetectOS

RSpec.configure do |c|
  c.before :all do
    c.os = backend(Serverspec::Commands::Base).check_os
  end
  c.path = "/sbin:/usr/sbin"
end

describe package('httpd') do
  it { should be_installed }
end

describe service('httpd') do
  it { should be_enabled }
end

describe service('httpd') do
  it { should be_running }
end

describe port(80) do
  it { should be_listening }
end

describe file('/var/www/html/index.html') do
  it { should be_file }
end


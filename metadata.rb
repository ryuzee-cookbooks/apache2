name             'apache2'
maintainer       'Ryutaro YOSHIBA'
maintainer_email 'ryuzee@gmail.com'
license          'MIT'
description      'Installs/Configures apache2'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.2.1'
depends          "yum", "~> 3.0.4"

%w{redhat centos scientific fedora amazon ubuntu}.each do |os|
    supports os
end

name             'uhostchef11server'
maintainer       'Mark C Allen'
maintainer_email 'mark@markcallen.com'
license          'All rights reserved'
description      'Installs/Configures chef11server on uhost'
long_description 'Installs/Configures chef11server on uhost'
version          '0.2.0'

%w{ ubuntu fedora centos }.each do |os|
  supports os
end

%w{ apt nginx hostsfile users }.each do |cb|
  depends cb
end

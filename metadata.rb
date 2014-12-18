name             'uhostchef11server'
maintainer       'Mark C Allen'
maintainer_email 'mark@markcallen.com'
license          'Apache 2.0'
description      'Installs/Configures chef11server on uhost'
long_description 'Installs/Configures chef11server on uhost'
version          '0.3.0'

%w{ ubuntu centos }.each do |os|
  supports os
end

%w{ apt nginx hostsfile users nodejs mongodb }.each do |cb|
  depends cb
end

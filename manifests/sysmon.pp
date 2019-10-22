# == Class: threatstack::sysmon
#
# Install Sysmon for Windows
#
# === Authors
#
# Nate St. Germain <nate.stgermain@threatstack.com>
#
# === Copyright
#
# Copyright 2019 Threat Stack, Inc.
#
class threatstack::sysmon {

  archive { "C:\\Windows\\Temp\\sysmon.zip":
    ensure       => present,
    extract      => true,
    cleanup      => true,
    extract_path => "C:\\Windows\\Temp\\",
    source       => 'https://download.sysinternals.com/files/Sysmon.zip'
  }

  file { 'C:\Windows\Temp\sysmonconfig-export.xml':
    ensure   => present,
    source   => 'https://raw.githubusercontent.com/SwiftOnSecurity/sysmon-config/master/sysmonconfig-export.xml',
    checksum => 'b03fab566310ff214c9285131a0d148f',
    require  => Exec['test conf present']
  }

  exec { 'test conf present':
    command => '/usr/bin/true',
    path    => '/usr/bin',
    unless  => '/usr/bin/dir C:\Windows\Temp\sysmonconfig-export.xml'
  }

  exec { 'Install sysmon':
    command     => "C:\\Windows\\Temp\\Sysmon64.exe –accepteula –i sysmonconfig-export.xml",
    subscribe   => File['C:\Windows\Temp\sysmonconfig-export.xml'],
    refreshonly => true,
    require     => [
      Archive["C:\\Windows\\Temp\\sysmon.zip"],
      File['C:\Windows\Temp\sysmonconfig-export.xml']
    ]
  }
}

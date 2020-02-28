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
# Copyright 2020 Threat Stack, Inc.
#
class threatstack::sysmon {

  archive { 'C:\Windows\Temp\sysmon.zip':
    ensure       => present,
    extract      => true,
    cleanup      => true,
    extract_path => 'C:\Windows\Temp',
    source       => 'https://download.sysinternals.com/files/Sysmon.zip'
  }

  remote_file { 'C:\Windows\Temp\sysmonconfig-export.xml':
    ensure  => present,
    source  => 'https://raw.githubusercontent.com/SwiftOnSecurity/sysmon-config/master/sysmonconfig-export.xml',
    require => Exec['test conf present']
  }

  exec { 'test conf present':
    command => 'C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe Test-Path C:\Windows\Temp\sysmonconfig-export.xml',
    unless  => 'C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe Test-Path C:\Windows\Temp\sysmonconfig-export.xml'
  }

  exec { 'Install sysmon':
    command     => 'C:\Windows\Temp\Sysmon64.exe -accepteula -i C:\Windows\Temp\sysmonconfig-export.xml',
    subscribe   => Remote_File['C:\Windows\Temp\sysmonconfig-export.xml'],
    refreshonly => true,
    unless      => 'C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe Get-Process "sysmon64"',
    require     => [
      Archive['C:\Windows\Temp\sysmon.zip'],
      Remote_File['C:\Windows\Temp\sysmonconfig-export.xml']
    ]
  }
}

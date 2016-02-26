# Setup apt repo and install the threatstack agent
#
# == Authors
#
# Pete Cheslock
#
class threatstack::apt {
  $apt_source_file = '/etc/apt/sources.list.d/threatstack.list'

  Exec {
    path => ['/usr/bin']
  }

  ensure_resource( 'package','curl', { 'ensure' => 'installed' } )

  package { $threatstack::ts_package:
    ensure  => installed,
    require => [
      File[$apt_source_file],
      Exec['Threat Stack GPG Import'],
      Exec['ts-agent-apt-get-update']
    ]
  }

  file { $apt_source_file:
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => "deb ${threatstack::repo_url} ${::lsbdistcodename} main",
    notify  => Exec['ts-agent-apt-get-update']
  }

  exec { 'ts-agent-apt-get-update':
    command     => 'apt-get update',
    refreshonly => true
  }

  exec { 'Threat Stack GPG Import':
    command => "curl ${threatstack::gpg_key} | apt-key add -",
    unless  => 'apt-key list | grep "Threat Stack"',
    notify  => Exec['ts-agent-apt-get-update'],
    require => Package['curl']
  }
}

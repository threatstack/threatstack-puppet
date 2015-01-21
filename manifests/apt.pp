class threatstack::apt {
  $apt_source_file = '/etc/apt/sources.list.d/threatstack.list'

  package { 'curl':
    ensure => installed
  }

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
    command     => '/usr/bin/apt-get update',
    refreshonly => true
  }

  exec { 'Threat Stack GPG Import':
    command => "/usr/bin/curl ${threatstack::gpg_key} | /usr/bin/apt-key add -",
    unless  => '/usr/bin/apt-key list | grep "Threat Stack"',
    notify  => Exec['ts-agent-apt-get-update'],
    require => Package['curl']
  }
}

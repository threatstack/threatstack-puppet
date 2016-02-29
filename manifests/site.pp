# == Class: threatstack::site
#
# For use by Puppet test-kitchen only.
#
# === Authors
#
# Pete Cheslock <pete.cheslock@threatstack.com>
# Tom McLaughlin <tom.mclaughlin@threatstack.com>
#
# === Copyright
#
# Copyright 2016 Threat Stack, Inc.
#
include ::stdlib

# Used to test package_version parameter works.
if $::osfamily == 'RedHat' {
  $package_version = "1.4.3-1.1.el${::operatingsystemmajrelease}"
} elsif $operatingsystem == 'Debian' {
  $package_version = "1.4.3.0debian${::operatingsystemmajrelease}.0"
} elsif $operatingsystem == 'Ubuntu' {
  $os_ver = split($::operatingsystemmajrelease, '\.')
  $os_maj_ver = $os_ver[0]
  $package_version = "1.4.3.0ubuntu${os_maj_ver}.0"
}

if $::operatingsystem == 'Debian' {
  package { 'apt-transport-https':
    ensure => installed,
    before => Class['::threatstack']
  }
}

# See .kitchen.yml for setting this fact.
class { '::threatstack':
  deploy_key      => $::ts_deploy_key,
  package_version => $package_version
}

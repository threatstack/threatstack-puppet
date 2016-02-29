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
  $package_version = "1.4.2-1.1.el${::operatingsystemmajrelease}"
} elsif $::osfamily == 'Debian' {
  $pkg_os = downcase($::operatingsystem)
  $package_version = "1.4.2.0${pkg_os}14.1"
}

# See .kitchen.yml for setting this fact.
class { '::threatstack':
  deploy_key      => $::ts_deploy_key,
  package_version => $package_version
}

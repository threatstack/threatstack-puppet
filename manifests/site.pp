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
# Copyright 2020 Threat Stack, Inc.
#
include ::stdlib

if $::operatingsystem == 'Debian' {
  package { 'apt-transport-https':
    ensure => installed,
    before => Class['::threatstack']
  }
}

# See .kitchen.yml for setting this fact.
class { '::threatstack':
  deploy_key        => $::ts_deploy_key,
  agent_config_args => $::ts_config_args,
  package_version   => $::ts_package_version,
}

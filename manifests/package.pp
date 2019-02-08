# == Class: threatstack::package
#
# Install Threat Stack Agent package.
#
# === Examples
#
# class threatstack ( .. ) inherits threatstack::params { .. }
#
# === Authors
#
# Pete Cheslock <pete.cheslock@threatstack.com>
# Tom McLaughlin <tom.mclaughlin@threatstack.com>
# Nate St. Germain <nate.stgermain@threatstack.com>
#
# === Copyright
#
# Copyright 2019 Threat Stack, Inc.
#
class threatstack::package {

  class { $::threatstack::repo_class: }

  if $::threatstack::disable_auditd {
    exec { 'stop_auditd':
      command => '/sbin/service auditd stop',
      onlyif  => '/sbin/service auditd status'
    }

    exec { 'disable_auditd':
      command => '/bin/systemctl disable auditd',
      require => Exec['stop_auditd']
    }

  $required = [ Class[$::threatstack::repo_class], Exec['stop_auditd'] ]
  } else {
    $required = Class[$::threatstack::repo_class]
  }

  # NOTE: We do not signal the tsagent service to restart because the
  # package takes care of this.  The workflow differs between fresh
  # installation and upgrades.
  package { $::threatstack::ts_package:
    ensure  => $::threatstack::package_version,
    require => $required
  }
}

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
class threatstack::package inherits ::threatstack::params {

  class { $::threatstack::params::repo_class: }

  # NOTE: We do not signal the cloudsight service to restart because the
  # package takes care of this.  The workflow differs between fresh
  # installation and upgrades.
  package { $::threatstack::ts_package:
    ensure  => $::threatstack::package_version,
    require => Class[$::threatstack::repo_class]
  }

}

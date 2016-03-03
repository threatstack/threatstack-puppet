# == Class: threatstack::params
#
# Common module parameters.
#
# === Examples
#
# class threatstack ( .. ) inherits threatstack::params { .. }
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
class threatstack::params {

  $ts_package = 'threatstack-agent'
  $ruleset    = ['Base Rule Set']

  case $::osfamily {
    'RedHat', 'Amazon': {
      $repo_class = '::threatstack::yum'
      $gpg_key    = 'https://app.threatstack.com/RPM-GPG-KEY-THREATSTACK'

      if $::osfamily == 'Amazon' {
        $repo_url = 'https://pkg.threatstack.com/Amazon'
      }
      else {
        $repo_url = 'https://pkg.threatstack.com/CentOS'
      }

    }
    'Debian': {
      $repo_class = '::threatstack::apt'
      $gpg_key  = 'https://app.threatstack.com/APT-GPG-KEY-THREATSTACK'
      $repo_url = 'https://pkg.threatstack.com/Ubuntu'

    }
    default: {
      fail("Module ${module_name} does not support ${::operatingsystem}")
    }
  }


}

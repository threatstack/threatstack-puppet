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
# Nate St. Germain <nate.stgermain@threatstack.com>
#
# === Copyright
#
# Copyright 2019 Threat Stack, Inc.
#

class threatstack::params {
  $ts_package      = 'threatstack-agent'
  $ts_service      = 'threatstack'
  $package_version = 'installed'
  $rulesets        = ['Base Rule Set']
  $extra_args      = undef
  $cloudsight_bin  = '/usr/bin/tsagent'
  $confdir         = '/opt/threatstack/etc'

  case $facts['os']['family'] {
    'RedHat': {
      $repo_class       = '::threatstack::yum'
      $gpg_key          = 'https://app.threatstack.com/RPM-GPG-KEY-THREATSTACK'
      $gpg_key_file     = '/etc/pki/rpm-gpg/RPM-GPG-KEY-THREATSTACK'
      $gpg_key_file_uri = "file://${gpg_key_file}"
      $disable_auditd   = true

      case $facts['os']['name'] {
        'Amazon': {
              $repo_url       = "https://pkg.threatstack.com/v2/Amazon/${::operatingsystemmajrelease}"
            }
        /(CentOS|RedHat)/: {
              $repo_url         = "https://pkg.threatstack.com/v2/EL/${::operatingsystemmajrelease}"
            }
        default: { fail("Module ${module_name} does not support ${::operatingsystem}") }
      }
    }
    'Debian': {
      $repo_class     = '::threatstack::apt'
      $repo_url       = 'https://pkg.threatstack.com/v2/Ubuntu'
      $repo_gpg_id    = 'ACCC2B02EA3A2409557B0AB991BB3B3C6EE04BD4'
      $release        = $facts['os']['distro']['codename']
      $repos          = 'main'
      $gpg_key        = 'https://app.threatstack.com/APT-GPG-KEY-THREATSTACK'
      $disable_auditd = false
    }
    default: {
      fail("Module ${module_name} does not support ${::operatingsystem}")
    }
  }


}

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
  $ts_service = 'cloudsight'
  $ruleset    = ['Base Rule Set']

  case $::facts['os']['family'] {
    'RedHat': {
      $repo_class       = '::threatstack::yum'
      $gpg_key          = 'https://app.threatstack.com/RPM-GPG-KEY-THREATSTACK'
      $gpg_key_file     = '/etc/pki/rpm-gpg/RPM-GPG-KEY-THREATSTACK'
      $gpg_key_file_uri = "file://${gpg_key_file}"

      case $::facts['os']['name'] {
        'Amazon': { $repo_url = 'https://pkg.threatstack.com/Amazon'}
        /(CentOS|RedHat)/: { $repo_url = "https://pkg.threatstack.com/EL/${::operatingsystemmajrelease}" }
        default: { fail("Module ${module_name} does not support ${::operatingsystem}") }
      }
    }
    'Debian': {
      $repo_class   = '::threatstack::apt'
      $repo_comment = 'Threat Stack agent repo'
      $repo_url     = 'https://pkg.threatstack.com/Ubuntu'
      $repo_gpg_id  = 'ACCC2B02EA3A2409557B0AB991BB3B3C6EE04BD4'
      $release      = $::facts['os']['distro']['codename']
      $repos        = 'main'
    }
    default: {
      fail("Module ${module_name} does not support ${::operatingsystem}")
    }
  }


}

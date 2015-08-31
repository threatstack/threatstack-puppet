# == Class: threatstack
#
# This module installs and configures the
# Threat Stack host based agent
#
# == Authors
#
# Pete Cheslock
#
class threatstack(
  $deploy_key   = 'none',
  $ruleset = ['Base Rule Set'],
  $ts_package   = 'threatstack-agent',
  $ts_hostname  = $fqdn
) {
  if $deploy_key == 'none' {
    fail('deploy_key must be defined.')
  }

  case $::osfamily {
    'RedHat', 'CentOS', 'Amazon': {
      $gpg_key    = 'https://app.threatstack.com/RPM-GPG-KEY-THREATSTACK'

      if $::osfamily == 'Amazon' {
        $repo_url        = 'https://pkg.threatstack.com/Amazon'
      }
      else {
        $repo_url        = 'https://pkg.threatstack.com/CentOS'
      }

      include threatstack::yum
      include threatstack::configure
    }
    'Debian': {
      $gpg_key    = 'https://app.threatstack.com/APT-GPG-KEY-THREATSTACK'
      $repo_url   = 'https://pkg.threatstack.com/Ubuntu'

      include threatstack::apt
      include threatstack::configure
    }
    default: {
      fail("Module ${module_name} does not support ${::operatingsystem}")
    }
  }

}

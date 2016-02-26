# == Class: threatstack
#
# This module installs and configures the
# Threat Stack host based agent
#
# == Authors
#
# Pete Cheslock
#
class threatstack (
  $deploy_key   = 'none',
  $gpg_key      = $::threatstack::params::gpg_key,
  $repo_url     = $::threatstack::params::repo_url,
  $ruleset      = $::threatstack::params::ruleset,
  $ts_package   = $::threatstack::params::ts_package,
  $ts_hostname  = $::fqdn
) inherits ::threatstack::params {

  $ts_package = $::threatstack::params::ts_package

  if $deploy_key == 'none' {
    fail('deploy_key must be defined.')
  }

  anchor { '::threatstack::start': } ->
  class { '::threatstack::package': } ->
  class { '::threatstack::configure': } ->
  anchor { '::threatstack::end': }

}

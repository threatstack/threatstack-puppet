# == Class: threatstack
#
# Installs and configures the Threat Stack host based agent.
#
# === Examples
#
# Standard usage:
# class { '::threatstack':
#   deploy_key => 'MyDeployKey',
#   ruleset    => ['MyRuleset']
# }
#
# Package mirror usage:
# class { '::threatstack':
#   deploy_key => 'MyDeployKey',
#   ruleset    => ['MyRuleset'],
#   repo_url   => 'https://my-mirror.example.com/centos-6'
#   gpg_key    => 'https://my-mirror.example.com/RPM-GPG-KEY-THREATSTACK'
# }
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
class threatstack (
  $deploy_key      = undef,
  $gpg_key         = $::threatstack::params::gpg_key,
  $package_version = 'installed',
  $configure_agent = true,
  $repo_url        = $::threatstack::params::repo_url,
  $ruleset         = $::threatstack::params::ruleset,
  $ts_hostname     = $::fqdn
) inherits ::threatstack::params {

  $ts_package = $::threatstack::params::ts_package

  if $deploy_key == undef {
    fail('deploy_key must be defined.')
  }

  anchor { '::threatstack::start': } ->
  class { '::threatstack::package': } ->
  class { '::threatstack::configure': }
  anchor { '::threatstack::end': }

}

# == Class: threatstack
#
# Installs and configures the Threat Stack host based agent.
#
# === Parameters
#
# [*agent_extra_args*]
#   Extra arguments to pass on the command line during agent activation.
#   type: string
#
# [*configure_agent*]
#   Optionally disable agent configuration.  Useful if installing agent into a
#   base image.
#   type: bool
#
# [*deploy_key*]
#   Threat Stack agent deploy key.  This value is required.
#   type: string
#
# [*gpg_key*]
#   URL to repository GPG key.
#   type: string
#
# [*package_version*]
#   Manage agent package version.
#   type: string
#
# [*repo_url*]
#   URL of installation repo.  Useful to change if managing own repository.  See
#   also `gpg_key`.
#   type: string
#
# [*ruleset*]
#   Ruleset to apply to host.
#   type: string
#
# [*ts_hostname*]
#   Hostname as reported to Threat Stack.
#   type: string
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
  $deploy_key       = undef,
  $package_version  = 'installed',
  $configure_agent  = true,
  $agent_extra_args = '',
  $repo_url         = $::threatstack::params::repo_url,
  $gpg_key          = $::threatstack::params::gpg_key,
  $ruleset          = $::threatstack::params::ruleset,
  $ts_hostname      = $::fqdn
) inherits ::threatstack::params {

  $ts_package = $::threatstack::params::ts_package

  anchor { '::threatstack::start': } ->
  class { '::threatstack::package': } ->
  anchor { '::threatstack::end': }


  if $configure_agent {
    if $deploy_key == undef {
      fail('$deploy_key must be defined.')
    }

    class { '::threatstack::configure':
      require => Class['::threatstack::package'],
      before => Anchor['::threatstack::end'],
    }
  }
}

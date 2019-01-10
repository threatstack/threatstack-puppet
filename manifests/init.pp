# == Class: threatstack
#
# Installs and configures the Threat Stack host based agent.
#
# === Parameters
#
# [*agent_config_args*]
#   Arguments to be passed to `cloudsight setup`
#   type: string
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
# [*feature_plan*]
#   Threat Stack feature plan.  Available values are:
#     * investigate: Investigate plan
#     * monitor: Monitor plan
#     * legacy: Legacy Basic, Advanced, and Pro packaging
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
  $deploy_key        = undef,
  $feature_plan      = undef,
  $package_version   = 'installed',
  $configure_agent   = true,
  $agent_extra_args  = '',
  $agent_config_args = undef,
  $repo_url          = $::threatstack::params::repo_url,
  $gpg_key           = $::threatstack::params::gpg_key,
  $ruleset           = $::threatstack::params::ruleset,
  $confdir           = $::threatstack::params::confdir,
  $ts_hostname       = $::fqdn
) inherits ::threatstack::params {

  $ts_package = $::threatstack::params::ts_package

  anchor { '::threatstack::start': }
  -> class { '::threatstack::package': }
  anchor { '::threatstack::end': }


  if $configure_agent {
    if $deploy_key == undef {
      fail('$deploy_key must be defined.')
    }
    if $feature_plan == undef {
      fail('$feature_plan needs to be set to "monitor", "investigate", or a"legacy". See https://www.threatstack.com/plans')
    }

    class { '::threatstack::configure': }
    class { '::threatstack::service': }

    Class['::threatstack::package']
    -> Class['::threatstack::configure']
    -> Class['::threatstack::service']
    Anchor['::threatstack::end']
  }
}

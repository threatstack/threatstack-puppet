# == Class: threatstack::configure
#
# Configure the threatstack agent with key (required) and policy (optional).
#
# === Examples
#
# This class is not meant to be directly realized outside of
# Class['::threatstack'].
#
# === Authors
#
# Pete Cheslock <pete.cheslock@threatstack.com>
# Tom McLaughlin <tom.mclaughlin@threatstack.com>
# Nate St. Germain <nate.stgermain@threatstack.com>
#
# === Copyright
#
# Copyright 2018 Threat Stack, Inc.
#
class threatstack::configure {

  $rulesets       = $::threatstack::rulesets
  $ruleset_args   = $rulesets.map | $rule | {
        "--ruleset='${rule}'"
      }
  if $::threatstack::extra_args {
    $extra_args = $::threatstack::extra_args.map | $arg | {
          "--${arg.keys[0]}=${arg.values[0]}"
        }
    $full_setup_args = "${join($ruleset_args, ' ')} ${join($extra_args, ' ')}"
    } else {
      $full_setup_args = "${join($ruleset_args, ' ')}"
    }

  $cloudsight_bin = $::threatstack::cloudsight_bin
  $confdir        = $::threatstack::confdir

  if $::threatstack::agent_config_args {
  $full_config_args = $::threatstack::agent_config_args.map | $config | {
      "${config.keys[0]} ${config.values[0]}"
    }
  }

  exec { 'threatstack-agent-setup':
    command   => "${cloudsight_bin} setup --deploy-key='${::threatstack::deploy_key}' --hostname='${::threatstack::ts_hostname}' ${full_setup_args}",
    subscribe => Package[$threatstack::ts_package],
    creates   => "${confdir}/.audit",
    path      => ['/bin', '/usr/bin'],
    unless    => 'ps auwwwx| grep [t]sagentd'
  }

  # this file tracks state and is used to notify
  # Exec[threatstack-agent-configure] of the need to run.
  file { "${confdir}/.config_args":
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => join($full_config_args, "\n")
  }

  exec { 'threatstack-agent-configure':
    command     => "${cloudsight_bin} config -set ${join($full_config_args, ' ')}",
    subscribe   => File["${confdir}/.config_args"],
    refreshonly => true,
    path        => ['/bin', '/usr/bin'],
    notify      => Class['threatstack::service']
  }

}

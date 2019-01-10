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

  $rulesets       = $::threatstack::ruleset # bring value into scope.
  $ruleset_args   = inline_template("<% @rulesets.each do |ruleset| -%> --ruleset = '<% = ruleset %>'<% end -%>")
  $cloudsight_bin = $::threatstack::cloudsight_bin
  $confdir        = $::threatstack::confdir

  $feature_plan_arg = $::threatstack::feature_plan ? {
    investigate => 'agent_type="i"',
    monitor     => 'agent_type="m"',
    legacy      => 'agent_type="i"'
  }

  $full_config_args_list = delete_undef_values([$::threatstack::agent_config_args, $feature_plan_arg])
  $full_config_args = join($full_config_args_list, ' ')

  exec { 'threatstack-agent-setup':
    command   => "${cloudsight_bin} setup --deploy-key='${::threatstack::deploy_key}' --hostname='${::threatstack::ts_hostname}' ${ruleset_args} ${::threatstack::agent_extra_args}",
    subscribe => Package[$threatstack::ts_package],
    creates   => '/opt/threatstack/cloudsight/config/.audit',
    path      => '/usr/bin'
  }

  # this file tracks state and is used to notify
  # Exec[threatstack-agent-configure] of the need to run.
  file { "${confdir}/.config_args":
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => $full_config_args
  }

  exec { 'threatstack-agent-configure':
    command     => "${cloudsight_bin} config ${full_config_args}",
    subscribe   => File["${confdir}/.config_args"],
    refreshonly => true,
    path        => ['/bin', '/usr/bin'],
    notify      => Class['threatstack::service']
  }

}

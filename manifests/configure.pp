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
#
# === Copyright
#
# Copyright 2016 Threat Stack, Inc.
#
class threatstack::configure {

  $rulesets     = $::threatstack::ruleset # bring value into scope.
  $ruleset_args = inline_template("<% @rulesets.each do |ruleset| -%> --ruleset='<%= ruleset %>'<% end -%>")

  $feature_plan_arg = $::threatstack::feature_plan ? {
    investigate => 'agent_type="i"',
    monitor     => 'agent_type="m"',
    legacy      => 'agent_type="i"'
  }

  $full_config_args_list = delete_undef_values([$::threatstack::agent_config_args, $feature_plan_arg])
  $full_config_args = join($full_config_args_list, ' ')

  exec { 'threatstack-agent-setup':
    command   => "/opt/threatstack/bin/cloudsight setup --deploy-key='${::threatstack::deploy_key}' --hostname='${::threatstack::ts_hostname}' ${ruleset_args} ${::threatstack::agent_extra_args}",
    subscribe => Package[$threatstack::ts_package],
    creates   => '/opt/threatstack/cloudsight/config/.audit',
    path      => '/usr/bin'
  }

  # this file tracks state and is used to notify
  # Exec[threatstack-agent-configure] of the need to run.
  file { '/opt/threatstack/cloudsight/config/.config_args':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => $full_config_args
  }

  exec { 'threatstack-agent-configure':
    command     => "/opt/threatstack/bin/cloudsight config ${full_config_args}",
    subscribe   => File['/opt/threatstack/cloudsight/config/.config_args'],
    refreshonly => true,
    path        => ['/bin', '/usr/bin'],
    notify      => Class['threatstack::service']
  }

}

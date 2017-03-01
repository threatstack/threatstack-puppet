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

  $feature_plan_config = {
    investigate => 'agent_type="i"',
    monitor     => 'agent_type="m"',
    legacy      => 'agent_type="i"',
    undef       => 'agent_type="i"'
  }

  $feature_plan_arg = $feature_plan_config[$::threatstack::feature_plan]
  $config_args = delete_undef_values([$::threatstack::agent_config_args, $feature_plan_arg])
  $config_args_contents = join($config_args, ' ')

  exec { 'threatstack-agent-setup':
    command   => "/opt/threatstack/bin/cloudsight setup --deploy-key='${::threatstack::deploy_key}' --hostname='${::threatstack::ts_hostname}' ${ruleset_args} ${::threatstack::agent_extra_args}",
    subscribe => Package[$threatstack::ts_package],
    creates   => '/opt/threatstack/cloudsight/config/.audit',
    path      => '/usr/bin'
  }

  file { '/opt/threatstack/cloudsight/config/.config_args':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => $config_args_contents
  }

  exec { 'threatstack-agent-configure':
    command     => "/opt/threatstack/bin/cloudsight config ${::threatstack::agent_config_args}",
    subscribe   => File['/opt/threatstack/cloudsight/config/.config_args'],
    refreshonly => true,
    path        => ['/bin', '/usr/bin'],
    notify      => Class['threatstack::service']
  }

}

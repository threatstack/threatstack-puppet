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

  $rulesets     = $threatstack::ruleset # bring value into scope.
  $ruleset_args = inline_template("<% @rulesets.each do |ruleset| -%> --ruleset='<%= ruleset %>'<% end -%>")

  # We can't configure the agent without error in a testing environment.
  if $::ts_test_kitchen != undef {
    $return_codes = [0, 1]
  } else {
    $return_codes = [0]
  }

  exec { 'configure-threatstack-agent':
    command     => "/opt/threatstack/bin/cloudsight setup --deploy-key='${::threatstack::deploy_key}' --hostname='${::threatstack::ts_hostname}' ${ruleset_args}",
    subscribe   => Package[$threatstack::ts_package],
    refreshonly => true,
    returns     => $return_codes,
    path        => '/usr/bin'
  }

}

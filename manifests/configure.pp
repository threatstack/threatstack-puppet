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

  exec { 'configure-threatstack-agent':
    command     => "/opt/threatstack/bin/cloudsight setup --deploy-key='${::threatstack::deploy_key}' --hostname='${::threatstack::ts_hostname}' ${ruleset_args}",
    subscribe   => Package[$threatstack::ts_package],
    creates     => '/opt/threatstack/cloudsight/config/.secret',
    path        => '/usr/bin'
  }

}

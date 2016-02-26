# Configure the threatstack agent with key(required)
# and the policy(optional)
#
# == Authors
#
# Pete Cheslock
#
class threatstack::configure {

  $rulesets     = $threatstack::ruleset # bring value into scope.
  $ruleset_args = inline_template("<% @rulesets.each do |ruleset| -%> --ruleset='<%= ruleset %>'<% end -%>")

  exec { 'configure-threatstack-agent':
    command     => "/opt/threatstack/bin/cloudsight setup --deploy-key='${::threatstack::deploy_key}' --hostname='${::threatstack::ts_hostname}' ${ruleset_args}",
    subscribe   => Package[$threatstack::ts_package],
    refreshonly => true,
    path        => '/usr/bin'
  }

}

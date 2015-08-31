# Configure the threatstack agent with key(required)
# and the policy(optional)
#
# == Authors
#
# Pete Cheslock
#
class threatstack::configure {

  exec { 'configure-threatstack-agent':
    command => inline_template("/opt/threatstack/bin/cloudsight setup --deploy-key='<%= scope.lookupvar('threatstack::deploy_key')%>' --hostname='<%= scope.lookupvar('threatstack::ts_hostname')%>' <% scope.lookupvar('threatstack::ruleset').each do |ruleset| -%> --ruleset='<%= ruleset %>' <% end -%>"),
    subscribe   => Package[$threatstack::ts_package],
    refreshonly => true,
    path => '/usr/bin'
  }

}

# Configure the threatstack agent with key(required)
# and the policy(optional)
#
# == Authors
#
# Pete Cheslock
#
class threatstack::configure {

  exec { 'configure-threatstack-agent':
    command     => "/opt/threatstack/bin/cloudsight setup --deploy-key=${threatstack::deploy_key} --policy='${threatstack::policy}' --hostname='${threatstack::ts_hostname}'",
    subscribe   => Package[$threatstack::ts_package],
    refreshonly => true,
  }
}

class threatstack::configure {

  exec { 'configure-threatstack-agent':
    command     => "/opt/threatstack/bin/cloudsight setup --deploy-key=${threatstack::deploy_key} --policy=${threatstack::policy}",
    subscribe   => Package[$threatstack::ts_package],
    refreshonly => true,
  }
}

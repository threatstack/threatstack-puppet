# == Class: threatstack::service
#
# Manage the Threat Stack agent service
#
# === Authors
#
# Tom McLaughlin <tom.mclaughlin@threatstack.com>
# Nate St. Germain <nate.stgermain@threatstack.com>
#
# === Copyright
#
# Copyright 2020 Threat Stack, Inc.
#
class threatstack::service {

  # NOTE: We do not signal the tsagent service to restart via the package
  # resource because the workflow differs between fresh installation and
  # upgrades.  The package scripts will handle this.
  service { $::threatstack::ts_service:
    ensure     => running,
    enable     => true,
    hasrestart => true,
    provider   => $::threatstack::service_provider
  }

}

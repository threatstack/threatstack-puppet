# == Class: threatstack::service
#
# Manage the Threat Stack agent service
#
# === Authors
#
# Tom McLaughlin <tom.mclaughlin@threatstack.com>
#
# === Copyright
#
# Copyright 2016 Threat Stack, Inc.
#
class threatstack::service {

  service { $::threatstack::ts_service:
    ensure     => running,
    enable     => true,
    hasrestart => true
  }

}

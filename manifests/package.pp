# Install Threat Stack agent package.
#
# == Authors
#
# Tom McLaughlin
#
class threatstack::package {

  class { $::threatstack::repo_class: }

  package { $::threatstack::ts_package:
    ensure  => installed,
    require => Class[$::threatstack::repo_class]
  }

}

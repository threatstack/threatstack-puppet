# Install Threat Stack agent package.
#
# == Authors
#
# Tom McLaughlin
#
class threatstack::package {
  case $::osfamily {
    'RedHat', 'CentOS', 'Amazon': {
      $repo_class = '::threatstack::yum'
    }
    'Debian': {
      $repo_class = '::threatstack::apt'
    }
    default: {
      fail("Module ${module_name} does not support ${::operatingsystem}")
    }
  }

  class { $repo_class: }

  package { $::threatstack::ts_package:
    ensure  => installed,
    require => Class[$repo_class]
  }
}

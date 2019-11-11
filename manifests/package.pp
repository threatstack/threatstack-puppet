# == Class: threatstack::package
#
# Install Threat Stack Agent package.
#
# === Examples
#
# class threatstack ( .. ) inherits threatstack::params { .. }
#
# === Authors
#
# Pete Cheslock <pete.cheslock@threatstack.com>
# Tom McLaughlin <tom.mclaughlin@threatstack.com>
# Nate St. Germain <nate.stgermain@threatstack.com>
#
# === Copyright
#
# Copyright 2019 Threat Stack, Inc.
#
class threatstack::package {

  class { $::threatstack::repo_class: }

  if $::threatstack::disable_auditd {
    service { 'auditd':
      ensure   => stopped,
      enable   => false,
      provider => $::threatstack::disable_auditd_provider,
    }

  $required = [ Class[$::threatstack::repo_class], Service['auditd'] ]
  } else {
    $required = Class[$::threatstack::repo_class]
  }

  # NOTE: We do not signal the tsagent service to restart because the
  # package takes care of this.  The workflow differs between fresh
  # installation and upgrades.
  case $facts['os']['family'] {
    'Windows': {
      remote_file { 'agent msi download':
        ensure => present,
        path   => $::threatstack::windows_tmp_path,
        source => $::threatstack::windows_download_url
      }

      package { $::threatstack::ts_package:
        ensure          => installed,
        source          => $::threatstack::windows_tmp_path,
        install_options => $::threatstack::windows_install_options,
        require         => Remote_file['agent msi download']
      }
    }
    default: {
      package { $::threatstack::ts_package:
        ensure  => $::threatstack::package_version,
        require => $required
      }
    }
  }
}

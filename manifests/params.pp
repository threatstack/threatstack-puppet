# == Class: threatstack::params
#
# Common module parameters.
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

class threatstack::params {
  $ts_package = $facts['os']['family'] ? {
    'Windows' => 'Threat Stack Cloud Security Platform',
    default   =>  'threatstack-agent'
  }

  $ts_service = $facts['os']['family'] ? {
    'Windows' => 'Threat Stack Agent',
    default   => 'threatstack'
  }

  $cloudsight_bin  = $facts['os']['family'] ? {
    'Windows' => "C:\\Program Files\\Threat Stack\\tsagent.exe",
    default   => '/usr/bin/tsagent'
  }

  $binpath = $facts['os']['family'] ? {
    'Windows' => ["C:\\Program Files\\Threat Stack\\"],
    default   => ['/bin', '/usr/bin']
  }

  $setup_unless = $facts['os']['family'] ? {
    'Windows' => 'tasklist.exe /fi "Imagename eq tsagent*"',
    default   =>'ps auwwwx| grep [t]sagentd'
  }

  $confdir = $facts['os']['family'] ? {
    'Windows' => "C:\\ProgramData\\Threat Stack\\config\\",
    default   => '/opt/threatstack/etc'
  }

  $rulesets = $facts['os']['family'] ? {
    'Windows' => ['Windows Rule Set'],
    default   => ['Base Rule Set']
  }

  $package_version = 'installed'
  $extra_args      = undef
  $windows_install_options = ['TSEVENTLOGLIST=Security,Microsoft-Windows-Sysmon/Operational']

  case $facts['os']['family'] {
    'Windows': {
      $repo_class              = '::threatstack::msi'
      $repo_url                = undef
      $gpg_key                 = undef
      $disable_auditd          = false
      $disable_auditd_provider = undef
      $windows_base_url        = 'https://pkg.threatstack.com/v2/Windows'
      $windows_pkg_name        = 'Threat+Stack+Cloud+Security+Agent.latest.msi'
      $download_url            = "${windows_base_url}/${windows_pkg_name}"
      $tmp_path                = "C:\\Windows\\Temp\\${windows_pkg_name}"
    }
    'RedHat': {
      $repo_class       = '::threatstack::yum'
      $gpg_key          = 'https://app.threatstack.com/RPM-GPG-KEY-THREATSTACK'
      $gpg_key_file     = '/etc/pki/rpm-gpg/RPM-GPG-KEY-THREATSTACK'
      $gpg_key_file_uri = "file://${gpg_key_file}"
      $disable_auditd   = true

      case $facts['os']['name'] {
        'Amazon': {
          if $facts['os']['release']['major'] =~ /^201\d$/ {
            $releasever              = '1'
            $disable_auditd_provider = undef
          } else {
            $releasever              = $facts['os']['release']['major']
            $disable_auditd_provider = 'redhat'
          }
          $repo_url = "https://pkg.threatstack.com/v2/Amazon/${releasever}"
        }
        /(CentOS|RedHat)/: {
          $repo_url                = "https://pkg.threatstack.com/v2/EL/${::operatingsystemmajrelease}"
          $disable_auditd_provider = 'redhat' #auditd can't be disabled using systemd: https://access.redhat.com/solutions/2664811
        }
        default: { fail("Module ${module_name} does not support ${::operatingsystem}") }
      }
    }
    'Debian': {
      $repo_class              = '::threatstack::apt'
      $repo_url                = 'https://pkg.threatstack.com/v2/Ubuntu'
      $repo_gpg_id             = 'ACCC2B02EA3A2409557B0AB991BB3B3C6EE04BD4'
      $release                 = $facts['os']['distro']['codename']
      $repos                   = 'main'
      $gpg_key                 = 'https://app.threatstack.com/APT-GPG-KEY-THREATSTACK'
      $disable_auditd          = false
      $disable_auditd_provider = undef
    }
    default: {
      fail("Module ${module_name} does not support ${::operatingsystem}")
    }
  }
}

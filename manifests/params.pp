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
# Copyright 2020 Threat Stack, Inc.
#

class threatstack::params {





  $package_version = 'installed'
  $extra_args      = undef
  $windows_install_options = ['TSEVENTLOGLIST=Security,Microsoft-Windows-Sysmon/Operational']

  case $facts['os']['family'] {
    'Windows': {
      $repo_class         = '::threatstack::msi'
      $repo_url           = undef
      $gpg_key            = undef
      $disable_auditd     = false
      $windows_base_url   = 'https://pkg.threatstack.com/v2/Windows'
      $windows_pkg_name   = 'Threat+Stack+Cloud+Security+Agent.latest.msi'
      $tmp_path           = "C:\\Windows\\Temp\\${windows_pkg_name}"
      $download_url       = "${windows_base_url}/${windows_pkg_name}"
      $rulesets           = ['Windows Rule Set']
      $enable_sysmon      = true
      $confdir            = "C:\\ProgramData\\Threat Stack\\config\\"
      $setup_unless       = 'tasklist.exe /fi "Imagename eq tsagent*"'
      $binpath            = ["C:\\Program Files\\Threat Stack\\"]
      $cloudsight_bin     = "C:\\Program Files\\Threat Stack\\tsagent.exe"
      $service_provider   = undef
      $ts_service         = 'Threat Stack Agent'
      $ts_package         = 'Threat Stack Cloud Security Platform'
    }
    'RedHat': {
      $repo_class       = '::threatstack::yum'
      $repo_enabled     = '1'
      $gpg_key          = 'https://app.threatstack.com/RPM-GPG-KEY-THREATSTACK'
      $gpg_key_file     = '/etc/pki/rpm-gpg/RPM-GPG-KEY-THREATSTACK'
      $gpg_key_file_uri = "file://${gpg_key_file}"
      $disable_auditd   = true
      $tmp_path         = undef
      $download_url     = undef
      $rulesets         = ['Base Rule Set']
      $enable_sysmon    = false
      $confdir          = '/opt/threatstack/etc'
      $setup_unless     = 'ps auwwwx| grep [t]sagentd'
      $binpath          = ['/bin', '/usr/bin']
      $cloudsight_bin   = '/usr/bin/tsagent'
      $ts_service       = 'threatstack'
      $ts_package       = 'threatstack-agent'

      case $facts['os']['name'] {
        'Amazon': {
          if $facts['os']['release']['major'] =~ /^201\d$/ {
            $releasever         = '1'
            $service_provider   = 'upstart'
          } else {
            $releasever         = $facts['os']['release']['major']
            $service_provider   = undef
          }
            $repo_url = "https://pkg.threatstack.com/v2/Amazon/${releasever}"
        }
        /(CentOS|RedHat)/: {
              $repo_url           = "https://pkg.threatstack.com/v2/EL/${::operatingsystemmajrelease}"
              $service_provider   = undef
        }
        default: { fail("Module ${module_name} does not support ${::operatingsystem}") }
      }
    }
    'Debian': {
      $repo_class         = '::threatstack::apt'
      $repo_url           = 'https://pkg.threatstack.com/v2/Ubuntu'
      $repo_enabled       = undef
      $repo_gpg_id        = 'ACCC2B02EA3A2409557B0AB991BB3B3C6EE04BD4'
      $release            = $facts['os']['distro']['codename']
      $repos              = 'main'
      $gpg_key            = 'https://app.threatstack.com/APT-GPG-KEY-THREATSTACK'
      $disable_auditd     = false
      $tmp_path           = undef
      $download_url       = undef
      $rulesets           = ['Base Rule Set']
      $enable_sysmon      = false
      $confdir            = '/opt/threatstack/etc'
      $setup_unless       = 'ps auwwwx| grep [t]sagentd'
      $binpath            = ['/bin', '/usr/bin']
      $cloudsight_bin     = '/usr/bin/tsagent'
      $service_provider   = undef
      $ts_service         = 'threatstack'
      $ts_package         = 'threatstack-agent'
    }
    default: {
      fail("Module ${module_name} does not support ${::operatingsystem}")
    }
  }
}

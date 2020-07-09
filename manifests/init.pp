# == Class: threatstack
#
# Installs and configures the Threat Stack host based agent.
#
# === Parameters
#
# [*agent_config_args*]
#   Arguments to be passed to `tsagent setup`
#   type: array
#
# [*binpath*]
#   Used to set bin path for exec in the config class
#   type: Array
#
# [*disable_auditd*]
#   Required to work around issues with auditd on some distros
#   type: bool
#
# [*enable_sysmon*]
#   Windows: optionally enable sysmon
#   type: bool
#
# [*extra_args*]
#   Extra arguments to pass on the command line during agent activation.
#   type: array of hashes
#   default: undef
#
# [*configure_agent*]
#   Optionally disable agent configuration.  Useful if installing agent into a
#   base image.
#   type: bool
#
# [*deploy_key*]
#   Threat Stack agent deploy key.  This value is required.
#   type: string
#
# [*feature_plan*]
#   Threat Stack feature plan.  Available values are:
#     * investigate: Investigate plan
#     * monitor: Monitor plan
#     * legacy: Legacy Basic, Advanced, and Pro packaging
#   type: string
#
# [*gpg_key*]
#   URL to repository GPG key.
#   type: string
#
# [*package_version*]
#   Manage agent package version.
#   type: string
#
# [*repo_enabled*]
#   Enable/disable yum repo
#   type: string
#
# [*repo_url*]
#   URL of installation repo.  Useful to change if managing own repository.  See
#   also `gpg_key`.
#   type: string
#
# [*rulesets*]
#   Ruleset(s) to apply to host.
#   type: array
#
# [*setup_unless*]
#   Used in the setup exec in the configure class
#   type: String
#
# [*tmpdir*]
#   Used to download Windows agent MSI
#   type: string
#
# [*ts_hostname*]
#   Hostname as reported to Threat Stack.
#   type: string
#
# [*service_provider*]
#   The Puppet Service provider used to manage the service. Defaults to undef on most distros
#   type: string
#
# [*windows_download_url*]
#   Windows MSI download url
#   type: string
#
# [*windows_install_options*]
#   Windows MSI install options
#   type: array
#
# [*windows_ts_package*]
#   Windows MSI package name
#   type: string
#
# === Examples
#
# Standard usage:
# class { '::threatstack':
#   deploy_key => 'MyDeployKey',
#   rulesets   => ['MyRuleset']
# }
#
# Package mirror usage:
# class { '::threatstack':
#   deploy_key => 'MyDeployKey',
#   rulesets   => ['MyRuleset'],
#   repo_url   => 'https://my-mirror.example.com/centos-6'
#   gpg_key    => 'https://my-mirror.example.com/RPM-GPG-KEY-THREATSTACK'
# }
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
class threatstack (
  $deploy_key              = undef,
  $package_version         = $::threatstack::params::package_version,
  $configure_agent         = true,
  $extra_args              = $::threatstack::params::extra_args,
  $agent_config_args       = undef,
  $repo_class              = $::threatstack::params::repo_class,
  $repo_enabled            = $::threatstack::params::repo_enabled,
  $repo_url                = $::threatstack::params::repo_url,
  $gpg_key                 = $::threatstack::params::gpg_key,
  $rulesets                = $::threatstack::params::rulesets,
  $confdir                 = $::threatstack::params::confdir,
  $ts_hostname             = $::fqdn,
  $disable_auditd          = $::threatstack::params::disable_auditd,
  $binpath                 = $::threatstack::params::binpath,
  $setup_unless            = $::threatstack::params::setup_unless,
  $enable_sysmon           = $::threatstack::params::enable_sysmon,
  $service_provider        = $::threatstack::params::service_provider,
  $windows_download_url    = $::threatstack::params::download_url,
  $windows_tmp_path        = $::threatstack::params::tmp_path,
  $windows_install_options = concat(["TSDEPLOYKEY=${deploy_key}"],$::threatstack::params::windows_install_options)

) inherits ::threatstack::params {

  $ts_package = $::threatstack::params::ts_package

  anchor { '::threatstack::start': }
  -> class { '::threatstack::package': }
  anchor { '::threatstack::end': }


  if $configure_agent {
    if $deploy_key == undef {
      fail('$deploy_key must be defined.')
    }
    # if $feature_plan == undef {
    #  fail('$feature_plan needs to be set to "monitor", "investigate", or a "legacy". See https://www.threatstack.com/plans')
    # }

    class { '::threatstack::configure': }
    class { '::threatstack::service': }

    Class['::threatstack::package']
    -> Class['::threatstack::configure']
    -> Class['::threatstack::service']
    Anchor['::threatstack::end']
  }
}

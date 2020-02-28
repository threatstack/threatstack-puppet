# == Class: threatstack::apt
#
# Setup Threat Stack APT repo.
#
# === Examples
#
# This class is not meant to be directly realized outside of
# Class['::threatstack'].
#
# === Authors
#
# Pete Cheslock <pete.cheslock@threatstack.com>
# Tom McLaughlin <tom.mclaughlin@threatstack.com>
# Nate St. Germain <nate.stgermain@threatstack.com>
#
# === Copyright
#
# Copyright 2020 Threat Stack
#

class threatstack::apt (
  $location = $threatstack::params::repo_url,
  $key      = $threatstack::params::repo_gpg_id,
  $release  = $threatstack::params::release,
  $repos    = $threatstack::params::repos,
  ) inherits ::threatstack::params {

  if !defined(Class['apt']) {
    class { 'apt': }
  }

  apt::source { 'threatstack':
    location => $location,
    release  => $release,
    repos    => $repos,
    key      => {
      'id'     => $key,
    }
  }
}

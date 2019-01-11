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
# Copyright 2019 Threat Stack
#

class threatstack::apt {
  $repo_url        = $threatstack::params::repo_url
  $repo_gpg_id     = $threatstack::params::repo_gpg_id
  $release         = $threatstack::params::release
  $repos           = $threatstack::params::repos

  if !defined(Class['apt']) {
    class { 'apt': }
  }

  apt::source { 'threatstack':
    location => $repo_url,
    release  => $release,
    repos    => $repos,
    key      => {
      'id'     => $repo_gpg_id,
      'server' => 'hkps.pool.sks-keyservers.net'
      }
  }
}

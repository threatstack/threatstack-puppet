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
#
# === Copyright
#
# Copyright 2018 Threat Stack
#

class threatstack::apt {
  $apt_source_file = '/etc/apt/sources.list.d/threatstack.list'
  $repo_comment    = $threatstack::params::repo_comment
  $repo_url        = $threatstack::params::repo_url
  $repo_gpg_id     = $threatstack::params::repo_gpg_id
  $release         = $threatstack::params::release
  $repos           = $threatstack::params::repos

  if !defined(Class['apt']) {
    class { 'apt': }
  }

  apt::source { 'threatstack':
    location => $repo_url,
    comment  => $repo_comment,
    release  => $release,
    repos    => $repos,
    key      => {
      'id'     => $repo_gpg_id,
      'server' => 'hkps.pool.sks-keyservers.net'
      }
  }
}

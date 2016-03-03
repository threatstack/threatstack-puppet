# == Class: threatstack::yum
#
# Setup Threat Stack YUM repo.
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
# Copyright 2016 Threat Stack, Inc.
#
class threatstack::yum {
  yumrepo { 'threatstack':
    descr    => 'Threat Stack Package Repository',
    enabled  => 1,
    baseurl  => $::threatstack::repo_url,
    gpgcheck => 1,
    gpgkey   => $::threatstack::gpg_key
  }
}

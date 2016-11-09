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
  Exec {
    path => ['/bin', '/usr/bin']
  }

  # Our site only supports TLS > 1.0 which curl, used by yum, does not support
  # in RHEL 6.  We use wget because even better, the --tlsv1 flag to curl does
  # not work before 6.7.
  ensure_packages('wget')

  exec { 'ts-gpg-fetch':
    command => "wget ${::threatstack::gpg_key} -O ${::threatstack::gpg_key_file}",
    creates => $::threatstack::gpg_key_file
  }

  yumrepo { 'threatstack':
    descr    => 'Threat Stack Package Repository',
    enabled  => 1,
    baseurl  => $::threatstack::repo_url,
    gpgcheck => 1,
    gpgkey   => $::threatstack::gpg_key_file_uri,
    require  => Exec['ts-gpg-fetch']
  }
}

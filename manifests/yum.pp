# Setup yum repo and install the threatstack agent
#
# == Authors
#
# Pete Cheslock
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

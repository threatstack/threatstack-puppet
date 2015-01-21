class threatstack::yum {
  yumrepo { 'threatstack':
    descr    => 'Threat Stack Package Repository',
    enabled  => 1,
    baseurl  => $threatstack::repo_url,
    gpgcheck => 1,
    gpgkey   => 'https://www.threatstack.com/RPM-GPG-KEY-THREATSTACK',
  }

  package { $threatstack::ts_package:
    ensure  => installed,
    require => [ Yumrepo['threatstack'] ]
  }
}

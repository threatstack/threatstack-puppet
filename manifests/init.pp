class threatstack(
  $deploy_key = 'none',
  $policy     = 'Default Policy',
  $ts_package = 'threatstack-agent'
) {
  if $deploy_key == 'none' {
    fail('deploy_key must be defined.')
  }

  case $::osfamily {
    'RedHat', 'CentOS', 'Amazon': {
      $gpg_key    = 'https://www.threatstack.com/RPM-GPG-KEY-THREATSTACK'

      if $::osfamily == 'Amazon' {
        $repo_url        = 'https://pkg.threatstack.com/Amazon'
      }
      else {
        $repo_url        = 'https://pkg.threatstack.com/CentOS'
      }

      include threatstack::yum
      include threatstack::configure
    }
    'Debian': {
      $gpg_key    = 'https://www.threatstack.com/APT-GPG-KEY-THREATSTACK'
      $repo_url   = 'https://pkg.threatstack.com/Ubuntu'

      include threatstack::apt
      include threatstack::configure
    }
    default: {
      fail("Module ${module_name} does not support ${::operatingsystem}")
    }
  }

}

require 'spec_helper'

describe 'threatstack::yum' do

  deploy_key = ENV['TS_DEPLOY_KEY'] ? ENV['TS_DEPLOY_KEY'] : "xKkRzesqg"
  gpgkey = 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-THREATSTACK'

  context 'on RedHat 8' do
    let(:facts) {  { :operatingsystem => 'RedHat', 'operatingsystemrelease' => '8.2.2004', :osfamily => 'RedHat', 'operatingsystemmajrelease' => '8', 'os' => { 'release' => { 'major' => '8'}, 'name' => 'RedHat', 'family' => 'RedHat'} } }
    let(:pre_condition) { "class { 'threatstack': deploy_key => '#{deploy_key}', gpg_key => 'https://app.threatstack.com/RPM-GPG-KEY-THREATSTACK', repo_enabled => '1', disable_auditd => true }"  }

    context 'default' do
      it { should contain_yumrepo('threatstack').with(
        :descr     => 'Threat Stack Package Repository',
        :enabled   => 1,
        :baseurl   => 'https://pkg.threatstack.com/v2/EL/8',
        :gpgcheck  => 1,
        :gpgkey    => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-THREATSTACK'
      ) }
    end
  end

  context 'on RedHat 7' do
    let(:facts) {  { :operatingsystem => 'RedHat', 'operatingsystemrelease' => '7.6.1810', :osfamily => 'RedHat', 'operatingsystemmajrelease' => '7', 'os' => { 'release' => { 'major' => '7'}, 'name' => 'RedHat', 'family' => 'RedHat'} } }
    let(:pre_condition) { "class { 'threatstack': deploy_key => '#{deploy_key}', gpg_key => 'https://app.threatstack.com/RPM-GPG-KEY-THREATSTACK', disable_auditd => true }"  }

    context 'default' do
      it { should contain_yumrepo('threatstack').with(
        :descr     => 'Threat Stack Package Repository',
        :enabled   => 1,
        :baseurl   => 'https://pkg.threatstack.com/v2/EL/7',
        :gpgcheck  => 1,
        :gpgkey    => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-THREATSTACK'
      ) }
    end
  end

  context 'on CentOS 8' do
    let(:facts) { {:operatingsystem => 'CentOS', 'operatingsystemrelease' => '8.2.2004', :osfamily => 'RedHat', 'operatingsystemmajrelease' => '8', 'os' => { 'release' => { 'major' => '8'}, 'name' => 'CentOS', 'family' => 'RedHat'} } }
    let(:pre_condition) { "class { 'threatstack': deploy_key => '#{deploy_key}', gpg_key => 'https://app.threatstack.com/RPM-GPG-KEY-THREATSTACK', repo_enabled => '1', disable_auditd => true }"  }

    context 'default' do
      it { should contain_yumrepo('threatstack').with(
        :descr     => 'Threat Stack Package Repository',
        :enabled   => 1,
        :baseurl   => 'https://pkg.threatstack.com/v2/EL/8',
        :gpgcheck  => 1,
        :gpgkey    => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-THREATSTACK'
      ) }
    end
  end

  context 'on CentOS 7' do
    let(:facts) { {:operatingsystem => 'CentOS', 'operatingsystemrelease' => '7.6.1810', :osfamily => 'RedHat', 'operatingsystemmajrelease' => '7', 'os' => { 'release' => { 'major' => '7'}, 'name' => 'CentOS', 'family' => 'RedHat'} } }
    let(:pre_condition) { "class { 'threatstack': deploy_key => '#{deploy_key}', gpg_key => 'https://app.threatstack.com/RPM-GPG-KEY-THREATSTACK', disable_auditd => true }"  }

    context 'default' do
      it { should contain_yumrepo('threatstack').with(
        :descr     => 'Threat Stack Package Repository',
        :enabled   => 1,
        :baseurl   => 'https://pkg.threatstack.com/v2/EL/7',
        :gpgcheck  => 1,
        :gpgkey    => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-THREATSTACK'
      ) }
    end
  end

  context 'on Amazon Linux 2' do
    let(:facts) {  { :operatingsystem => 'Amazon', :osfamily => 'RedHat', 'operatingsystemmajrelease' => '2', 'os' => {  'release' => { 'major' => '2'}, 'name' => 'Amazon', 'family' => 'RedHat'} } }
    let(:pre_condition) { "class { 'threatstack': deploy_key => '#{deploy_key}', gpg_key => 'https://app.threatstack.com/RPM-GPG-KEY-THREATSTACK', disable_auditd => true }"  }

    context 'default' do
      it { should contain_yumrepo('threatstack').with(
        :descr     => 'Threat Stack Package Repository',
        :enabled   => 1,
        :baseurl   => 'https://pkg.threatstack.com/v2/Amazon/2',
        :gpgcheck  => 1,
        :gpgkey    => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-THREATSTACK'
      ) }
    end
  end

  context 'on Amazon Linux 1' do
    let(:facts) {  { :operatingsystem => 'Amazon', :osfamily => 'RedHat', 'operatingsystemmajrelease' => '2018', 'os' => {  'release' => { 'major' => '2018'}, 'name' => 'Amazon', 'family' => 'RedHat'} } }
    let(:pre_condition) { "class { 'threatstack': deploy_key => '#{deploy_key}', gpg_key => 'https://app.threatstack.com/RPM-GPG-KEY-THREATSTACK', disable_auditd => true }"  }

    context 'default' do
      it { should contain_yumrepo('threatstack').with(
        :descr     => 'Threat Stack Package Repository',
        :enabled   => 1,
        :baseurl   => 'https://pkg.threatstack.com/v2/Amazon/1',
        :gpgcheck  => 1,
        :gpgkey    => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-THREATSTACK'
      ) }
    end
  end
end
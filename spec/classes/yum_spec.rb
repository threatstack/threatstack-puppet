require 'spec_helper'

describe 'threatstack::yum' do

  deploy_key = ENV['TS_DEPLOY_KEY'] ? ENV['TS_DEPLOY_KEY'] : "xKkRzesqg"
  gpgkey = 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-THREATSTACK'

  context 'on RedHat' do
    let(:facts) {  { 'osfamily' => 'RedHat', 'operatingsystemmajrelease' => '7', 'os' => { 'release' => { 'major' => '7'}, 'name' => 'RedHat', 'family' => 'RedHat'} } }
    let(:pre_condition) { "class { 'threatstack': deploy_key => '#{deploy_key}', gpg_key => 'https://app.threatstack.com/RPM-GPG-KEY-THREATSTACK' }" }

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

  context 'on CentOS' do
    let(:facts) { {'osfamily' => 'RedHat', 'operatingsystemmajrelease' => '7', 'os' => { 'release' => { 'major' => '7'}, 'name' => 'CentOS', 'family' => 'RedHat'} } }
    let(:pre_condition) { "class { 'threatstack': deploy_key => '#{deploy_key}', gpg_key => 'https://app.threatstack.com/RPM-GPG-KEY-THREATSTACK' }" }

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
    let(:facts) {  {'osfamily' => 'RedHat', 'operatingsystemmajrelease' => '2', 'os' => {  'release' => { 'major' => '2'}, 'name' => 'Amazon', 'family' => 'RedHat'} } }
    let(:pre_condition) { "class { 'threatstack': deploy_key => '#{deploy_key}', gpg_key => 'https://app.threatstack.com/RPM-GPG-KEY-THREATSTACK' }" }

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
    let(:facts) {  {'osfamily' => 'RedHat', 'operatingsystemmajrelease' => '2018', 'os' => {  'release' => { 'major' => '2018'}, 'name' => 'Amazon', 'family' => 'RedHat'} } }
    let(:pre_condition) { "class { 'threatstack': deploy_key => '#{deploy_key}', gpg_key => 'https://app.threatstack.com/RPM-GPG-KEY-THREATSTACK' }" }

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

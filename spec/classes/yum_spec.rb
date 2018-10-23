require 'spec_helper'

describe 'threatstack::yum' do

  deploy_key = ENV['TS_DEPLOY_KEY'] ? ENV['TS_DEPLOY_KEY'] : "xKkRzesqg"
  feature_plan = ENV['TS_FEATURE_PLAN'] ? ENV['TS_FEATURE_PLAN'] : "monitor"

  context 'on RedHat' do
    let(:facts) { {:osfamily => 'RedHat', :operatingsystemmajrelease => '6', :operatingsystem => 'RedHat'} }
    let(:pre_condition) { "class { 'threatstack': deploy_key => '#{deploy_key}', feature_plan => '#{feature_plan}' }" }

    context 'default' do
      it { should contain_yumrepo('threatstack').with(
        :descr     => 'Threat Stack Package Repository',
        :enabled   => 1,
        :baseurl   => 'https://pkg.threatstack.com/EL/6',
        :gpgcheck  => 1,
        :gpgkey    => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-THREATSTACK'
      ) }
    end
  end

  context 'on CentOS' do
    let(:facts) { {:osfamily => 'RedHat', :operatingsystemmajrelease => '7', :operatingsystem => 'CentOS'} }
    let(:pre_condition) { "class { 'threatstack': deploy_key => '#{deploy_key}', feature_plan => '#{feature_plan}' }" }

    context 'default' do
      it { should contain_yumrepo('threatstack').with(
        :descr     => 'Threat Stack Package Repository',
        :enabled   => 1,
        :baseurl   => 'https://pkg.threatstack.com/EL/7',
        :gpgcheck  => 1,
        :gpgkey    => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-THREATSTACK'
      ) }
    end
  end

  context 'on Amazon' do
    let(:facts) { {:osfamily => 'RedHat', :operatingsystem => 'Amazon'} }
    let(:pre_condition) { "class { 'threatstack': deploy_key => '#{deploy_key}', feature_plan => '#{feature_plan}' }" }

    context 'default' do
      it { should contain_yumrepo('threatstack').with(
        :descr     => 'Threat Stack Package Repository',
        :enabled   => 1,
        :baseurl   => 'https://pkg.threatstack.com/Amazon',
        :gpgcheck  => 1,
        :gpgkey    => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-THREATSTACK'
      ) }
    end
  end

end

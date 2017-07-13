require 'spec_helper'

describe 'threatstack::yum' do

  deploy_key = ENV['TS_DEPLOY_KEY'] ? ENV['TS_DEPLOY_KEY'] : "xKkRzesqg"
  feature_plan = ENV['TS_FEATURE_PLAN'] ? ENV['TS_FEATURE_PLAN'] : "monitor"

  context 'on RedHat' do
    let(:facts) { {:osfamily => 'RedHat'} }
    let(:pre_condition) { "class { 'threatstack': deploy_key => '#{deploy_key}', feature_plan => '#{feature_plan}' }" }

    context 'default' do
      it { should contain_yumrepo('threatstack').with(
        :descr     => 'Threat Stack Package Repository',
        :enabled   => 1,
        :baseurl   => 'https://pkg.threatstack.com/CentOS',
        :gpgcheck  => 1,
        :gpgkey    => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-THREATSTACK'
      ) }
    end
  end

  context 'on CentOS' do
    let(:facts) { {:osfamily => 'RedHat'} }
    let(:pre_condition) { "class { 'threatstack': deploy_key => '#{deploy_key}', feature_plan => '#{feature_plan}' }" }

    context 'default' do
      it { should contain_yumrepo('threatstack').with(
        :descr     => 'Threat Stack Package Repository',
        :enabled   => 1,
        :baseurl   => 'https://pkg.threatstack.com/CentOS',
        :gpgcheck  => 1,
        :gpgkey    => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-THREATSTACK'
      ) }
    end
  end

  context 'on Amazon' do
    let(:facts) { {:osfamily => 'Amazon'} }
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

require 'spec_helper'

describe 'threatstack::yum' do

  deploy_key = ENV['TS_DEPLOY_KEY'] ? ENV['TS_DEPLOY_KEY'] : "xKkRzesqg"

  context 'on RedHat' do
    let(:facts) { {:osfamily => 'RedHat'} }
    let(:pre_condition) { "class { 'threatstack': deploy_key => '#{deploy_key}' }" }

    context 'default' do
      it { should contain_yumrepo('threatstack').with(
        :descr     => 'Threat Stack Package Repository',
        :enabled   => 1,
        :baseurl   => 'https://pkg.threatstack.com/CentOS',
        :gpgcheck  => 1,
        :gpgkey    => 'https://app.threatstack.com/RPM-GPG-KEY-THREATSTACK'
      ) }
    end
  end

  context 'on CentOS' do
    let(:facts) { {:osfamily => 'RedHat'} }
    let(:pre_condition) { "class { 'threatstack': deploy_key => '#{deploy_key}' }" }

    context 'default' do
      it { should contain_yumrepo('threatstack').with(
        :descr     => 'Threat Stack Package Repository',
        :enabled   => 1,
        :baseurl   => 'https://pkg.threatstack.com/CentOS',
        :gpgcheck  => 1,
        :gpgkey    => 'https://app.threatstack.com/RPM-GPG-KEY-THREATSTACK'
      ) }
    end
  end

  context 'on Amazon' do
    let(:facts) { {:osfamily => 'Amazon'} }
    let(:pre_condition) { "class { 'threatstack': deploy_key => '#{deploy_key}' }" }

    context 'default' do
      it { should contain_yumrepo('threatstack').with(
        :descr     => 'Threat Stack Package Repository',
        :enabled   => 1,
        :baseurl   => 'https://pkg.threatstack.com/Amazon',
        :gpgcheck  => 1,
        :gpgkey    => 'https://app.threatstack.com/RPM-GPG-KEY-THREATSTACK'
      ) }
    end
  end

end

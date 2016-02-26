require 'spec_helper'

describe 'threatstack::yum' do

  context 'on RedHat' do
    let(:facts) { {:osfamily => 'RedHat'} }

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

  context 'package' do
    let(:facts) { {:osfamily => 'RedHat'} }
    it { should contain_package('threatstack-agent').with_ensure('installed') }
  end

end

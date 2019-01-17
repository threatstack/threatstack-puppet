require 'spec_helper'

describe 'threatstack::package' do
  deploy_key = ENV['TS_DEPLOY_KEY'] ? ENV['TS_DEPLOY_KEY'] : "xKkRzesqg"

  context 'on RedHat' do
    let(:facts) {  { 'operatingsystem' => 'RedHat', 'operatingsystemmajrelease' => '7', 'os' => { 'release' => { 'full' => '7.5', 'major' => '7', 'minor' => '5'}, 'name' => 'RedHat', 'family' => 'RedHat'} } }
    let(:pre_condition) { "class { 'threatstack': deploy_key => '#{deploy_key}', gpg_key => 'https://app.threatstack.com/RPM-GPG-KEY-THREATSTACK', repo_class => '::threatstack::yum' }" }

    context 'package' do
      it { should contain_package('threatstack-agent').with_ensure('installed') }
    end
  end

  context 'on CentOS 7' do
    let(:facts) { {'operatingsystemmajrelease' => '7', 'os' => { 'release' => { 'major' => '7'}, 'name' => 'CentOS', 'family' => 'RedHat'} } }
    let(:pre_condition) { "class { 'threatstack': deploy_key => '#{deploy_key}', gpg_key => 'https://app.threatstack.com/RPM-GPG-KEY-THREATSTACK', repo_class => '::threatstack::yum' }" }

    context 'package' do
      it { should contain_package('threatstack-agent').with_ensure('installed') }
    end
  end

  context 'on Amazon Linux' do
    let(:facts) {  {'os' => {  'release' => { 'major' => '1'}, 'name' => 'Amazon', 'family' => 'RedHat'} } }
    let(:pre_condition) { "class { 'threatstack': deploy_key => '#{deploy_key}', gpg_key => 'https://app.threatstack.com/RPM-GPG-KEY-THREATSTACK', repo_class => '::threatstack::yum' }" }

    context 'package' do
      it { should contain_package('threatstack-agent').with_ensure('installed') }
    end
  end

  context 'on Debian 8' do
    let(:facts) { {'osfamily' => 'Debian', 'os' => { 'name' => 'Debian', 'release' => {'full' => '8.11', 'major' => '8', 'minor' => '11'}, 'distro' => {'codename' => 'jessie'}, 'family' => 'Debian'} } }
    let(:pre_condition) { "class { 'threatstack': deploy_key => '#{deploy_key}', gpg_key => 'https://app.threatstack.com/APT-GPG-KEY-THREATSTACK', repo_class => '::threatstack::apt' }" }

    context 'package' do
      it { should contain_package('threatstack-agent').with_ensure('installed') }
    end
  end

  context 'on Debian 9' do
    let(:facts) { {'operatingsystem' => 'Debian', 'osfamily' => 'Debian', 'os' => { 'name' => 'Debian', 'release' => {'full' => '9.1', 'major' => '9', 'minor' => '1'}, 'distro' => {'codename' => 'stretch'}, 'family' => 'Debian'} } }
    let(:pre_condition) { "class { 'threatstack': deploy_key => '#{deploy_key}', gpg_key => 'https://app.threatstack.com/APT-GPG-KEY-THREATSTACK', repo_class => '::threatstack::apt' }" }

    context 'package' do
      it { should contain_package('threatstack-agent').with_ensure('installed') }
    end
  end

  context 'on Ubuntu 18.04' do
    let(:facts) { {'osfamily' => 'Debian', 'os' => { 'name' => 'Ubuntu', 'release' => {'full' => '18.04', 'major' => '18.04'}, 'distro' => {'codename' => 'bionic'}, 'family' => 'Debian'} }}
    let(:pre_condition) { "class { 'threatstack': deploy_key => '#{deploy_key}', gpg_key => 'https://app.threatstack.com/APT-GPG-KEY-THREATSTACK', repo_class => '::threatstack::apt' }" }

    context 'package' do
      it { should contain_package('threatstack-agent').with_ensure('installed') }
    end
  end

  context 'on Ubuntu 16.04' do
    let(:facts) { {'osfamily' => 'Debian', 'os' => { 'name' => 'Ubuntu', 'release' => {'full' => '16.04', 'major' => '16.04'}, 'distro' => {'codename' => 'xenial'}, 'family' => 'Debian'} }}
    let(:pre_condition) { "class { 'threatstack': deploy_key => '#{deploy_key}', gpg_key => 'https://app.threatstack.com/APT-GPG-KEY-THREATSTACK', repo_class => '::threatstack::apt' }" }

    context 'package' do
      it { should contain_package('threatstack-agent').with_ensure('installed') }
    end
  end
end

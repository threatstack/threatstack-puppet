require 'spec_helper'

describe 'threatstack::apt' do

  deploy_key = ENV['TS_DEPLOY_KEY'] ? ENV['TS_DEPLOY_KEY'] : "xKkRzesqg"
  feature_plan = ENV['TS_FEATURE_PLAN'] ? ENV['TS_FEATURE_PLAN'] : "monitor"

  context 'on Debian' do
    let(:facts) { {:osfamily => 'Debian'} }
    let(:pre_condition) { "class { 'threatstack': deploy_key => '#{deploy_key}', feature_plan => '#{feature_plan}' }" }

    it { should contain_package('curl').with_ensure('installed') }
    it { should contain_exec('ts-agent-apt-get-update').with(
      :command => 'apt-get update'
    )}
    it { should contain_exec('ts-gpg-import').with(
      :command => 'curl https://app.threatstack.com/APT-GPG-KEY-THREATSTACK | apt-key add -'
    )}
  end

  context 'on Ubuntu Lucid 10.04' do
    let(:facts) { {:osfamily => 'Debian', :lsbdistcodename => 'lucid' } }
    let(:pre_condition) { "class { 'threatstack': deploy_key => '#{deploy_key}', feature_plan => '#{feature_plan}' }" }

    it { should contain_file('/etc/apt/sources.list.d/threatstack.list').with(
      :owner => 'root',
      :group => 'root',
      :mode  => '0644',
      :content => 'deb https://pkg.threatstack.com/Ubuntu lucid main'
    )}
  end

  context 'on Ubuntu Precise 12.04' do
    let(:facts) { {:osfamily => 'Debian', :lsbdistcodename => 'precise' } }
    let(:pre_condition) { "class { 'threatstack': deploy_key => '#{deploy_key}', feature_plan => '#{feature_plan}' }" }

    it { should contain_file('/etc/apt/sources.list.d/threatstack.list').with(
      :owner => 'root',
      :group => 'root',
      :mode  => '0644',
      :content => 'deb https://pkg.threatstack.com/Ubuntu precise main'
    )}
  end

  context 'on Ubuntu Trusy 14.04' do
    let(:facts) { {:osfamily => 'Debian', :lsbdistcodename => 'trusty' } }
    let(:pre_condition) { "class { 'threatstack': deploy_key => '#{deploy_key}', feature_plan => '#{feature_plan}' }" }

    it { should contain_file('/etc/apt/sources.list.d/threatstack.list').with(
      :owner => 'root',
      :group => 'root',
      :mode  => '0644',
      :content => 'deb https://pkg.threatstack.com/Ubuntu trusty main'
    )}
  end

end

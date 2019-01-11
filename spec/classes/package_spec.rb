require 'spec_helper'

describe 'threatstack::package' do

  deploy_key = ENV['TS_DEPLOY_KEY'] ? ENV['TS_DEPLOY_KEY'] : "xKkRzesqg"
  feature_plan = ENV['TS_FEATURE_PLAN'] ? ENV['TS_FEATURE_PLAN'] : "monitor"

  context 'on RedHat' do
    let(:facts) {  { 'operatingsystemmajrelease' => '7', 'os' => { 'release' => { 'major' => '7'}, 'family' => 'RedHat'} } }
    let(:pre_condition) { "class { 'threatstack': deploy_key => '#{deploy_key}', feature_plan => '#{feature_plan}' }" }

    context 'package' do
      it { should contain_package('threatstack-agent').with_ensure('installed') }
    end
  end

  context 'on Debian 8' do
    let(:facts) { {'osfamily' => 'Debian', 'os' => { 'name' => 'Debian', 'release' => {'full' => '8.11', 'major' => '8', 'minor' => '11'}, 'distro' => {'codename' => 'jessie'}, 'family' => 'Debian'} } }
    let(:pre_condition) { "class { 'threatstack': deploy_key => '#{deploy_key}', feature_plan => '#{feature_plan}' }" }

    context 'package' do
      it { should contain_package('threatstack-agent').with_ensure('installed') }
    end
  end

end

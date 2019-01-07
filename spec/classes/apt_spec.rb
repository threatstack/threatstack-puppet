require 'spec_helper'

describe 'ensure package resource' do
  it 'creates a curl package resource in the catalogue' do
    is_expected.to run.with_params('curl', {'ensure' => 'present'})
    expect(catalogue).to contain_package('curl').with_ensure('present')
  end
end

describe 'threatstack::apt' do

  deploy_key = ENV['TS_DEPLOY_KEY'] ? ENV['TS_DEPLOY_KEY'] : "xKkRzesqg"
  feature_plan = ENV['TS_FEATURE_PLAN'] ? ENV['TS_FEATURE_PLAN'] : "monitor"

  context 'on Debian' do
    let(:facts) { {'os' => { 'distro' => {'codename' => 'trusty'}, 'family' => 'Debian'} } }
    let(:pre_condition) { "class { 'threatstack': deploy_key => '#{deploy_key}', feature_plan => '#{feature_plan}' }" }

    it { should contain_exec('ts-agent-apt-get-update').with(
      :command => 'apt-get update'
    )}
    it { should contain_exec('ts-gpg-import').with(
      :command => 'curl https://app.threatstack.com/APT-GPG-KEY-THREATSTACK | apt-key add -'
    )}
  end

  context 'on Ubuntu Trusy 14.04' do
    let(:facts) { {'os' => { 'distro' => {'codename' => 'trusty'}, 'family' => 'Debian'} }}
    let(:pre_condition) { "class { 'threatstack': deploy_key => '#{deploy_key}', feature_plan => '#{feature_plan}' }" }

    it { should contain_file('/etc/apt/sources.list.d/threatstack.list').with(
      :owner => 'root',
      :group => 'root',
      :mode  => '0644',
      :content => 'deb https://pkg.threatstack.com/Ubuntu trusty main'
    )}
  end

end

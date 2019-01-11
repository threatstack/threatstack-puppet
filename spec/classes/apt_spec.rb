require 'spec_helper'

describe 'threatstack::apt' do

  deploy_key = ENV['TS_DEPLOY_KEY'] ? ENV['TS_DEPLOY_KEY'] : "xKkRzesqg"
  feature_plan = ENV['TS_FEATURE_PLAN'] ? ENV['TS_FEATURE_PLAN'] : "monitor"

  context 'on Debian 8' do
    let(:facts) { {'osfamily' => 'Debian', 'os' => { 'name' => 'Debian', 'distro' => {'codename' => 'jessie'}, 'family' => 'Debian'} } }
    let(:pre_condition) { "class { 'threatstack': deploy_key => '#{deploy_key}', feature_plan => '#{feature_plan}' }" }

    #add real debian tests here
  end

  context 'on Debian 9' do
    let(:facts) { {'osfamily' => 'Debian', 'os' => { 'name' => 'Debian', 'distro' => {'codename' => 'stretch'}, 'family' => 'Debian'} } }
    let(:pre_condition) { "class { 'threatstack': deploy_key => '#{deploy_key}', feature_plan => '#{feature_plan}' }" }

    #add real debian tests here
  end

  context 'on Ubuntu 18.04' do
    let(:facts) { {'osfamily' => 'Debian', 'os' => { 'name' => 'Ubuntu', 'release' => {'full' => '18'}, 'distro' => {'codename' => 'bionic'}, 'family' => 'Debian'} }}
    let(:pre_condition) { "class { 'threatstack': deploy_key => '#{deploy_key}', feature_plan => '#{feature_plan}' }" }

    it { should contain_file('/etc/apt/sources.list.d/threatstack.list').with(
      :owner => 'root',
      :group => 'root',
      :mode  => '0644',
      :content => "# This file is managed by Puppet. DO NOT EDIT.
# Threat Stack agent repo
deb https://pkg.threatstack.com/v2/Ubuntu bionic main"
    )}
  end

  context 'on Ubuntu 16.04' do
    let(:facts) { {'osfamily' => 'Debian', 'os' => { 'name' => 'Ubuntu', 'release' => {'full' => '18'}, 'distro' => {'codename' => 'xenial'}, 'family' => 'Debian'} }}
    let(:pre_condition) { "class { 'threatstack': deploy_key => '#{deploy_key}', feature_plan => '#{feature_plan}' }" }

    it { should contain_file('/etc/apt/sources.list.d/threatstack.list').with(
      :owner => 'root',
      :group => 'root',
      :mode  => '0644',
      :content => "# This file is managed by Puppet. DO NOT EDIT.
# Threat Stack agent repo
deb https://pkg.threatstack.com/v2/Ubuntu xenial main"
    )}
  end

  context 'on Ubuntu 14.04' do
    let(:facts) { {'osfamily' => 'Debian', 'os' => { 'name' => 'Ubuntu', 'release' => {'full' => '18'}, 'distro' => {'codename' => 'trusty'}, 'family' => 'Debian'} }}
    let(:pre_condition) { "class { 'threatstack': deploy_key => '#{deploy_key}', feature_plan => '#{feature_plan}' }" }

    it { should contain_file('/etc/apt/sources.list.d/threatstack.list').with(
      :owner => 'root',
      :group => 'root',
      :mode  => '0644',
      :content => "# This file is managed by Puppet. DO NOT EDIT.
# Threat Stack agent repo
deb https://pkg.threatstack.com/v2/Ubuntu trusty main"
    )}
  end

end

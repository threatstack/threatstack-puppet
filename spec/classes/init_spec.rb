require 'spec_helper'

describe 'threatstack' do

  deploy_key = ENV['TS_DEPLOY_KEY'] ? ENV['TS_DEPLOY_KEY'] : "xKkRzesqg"

  context 'on Debian 8' do
      let(:facts) { {'lsbdistcodename' => 'jessie', 'operatingsystem' => 'Debian', 'osfamily' => 'Debian', 'os' => { 'family' => 'Debian', 'name' => 'Debian', 'release' => { 'full' => '8.11', 'major' => '8', 'minor' => '11'}, 'distro' => {'release' => { 'full' => '8.11', 'major' => '8', 'minor' => '11', 'codename' => 'jessie'}, 'family' => 'Debian'} } } }
    let(:params) { { :deploy_key => "#{deploy_key}" } }

    it 'should compile' do should create_class('threatstack') end
    it { should contain_class('threatstack::package') }
    it { should contain_class('threatstack::configure') }
  end

  context 'on Debian 9' do
    let(:facts) { {'operatingsystem' => 'Debian', 'osfamily' => 'Debian', 'os' => { 'name' => 'Debian', 'release' => {'full' => '9.1', 'major' => '9', 'minor' => '1'}, 'distro' => {'codename' => 'stretch'}, 'family' => 'Debian'} } }
    let(:params) { { :deploy_key => "#{deploy_key}" } }

    it 'should compile' do should create_class('threatstack') end
    it { should contain_class('threatstack::package') }
    it { should contain_class('threatstack::configure') }
  end

  context 'on Ubuntu 18.04' do
    let(:facts) { {'osfamily' => 'Debian', 'os' => { 'name' => 'Ubuntu', 'release' => {'full' => '18.04', 'major' => '18.04'}, 'distro' => {'codename' => 'bionic'}, 'family' => 'Debian'} }}
    let(:params) { { :deploy_key => "#{deploy_key}" } }

    it 'should compile' do should create_class('threatstack') end
    it { should contain_class('threatstack::package') }
    it { should contain_class('threatstack::configure') }
  end

  context 'on Ubuntu 16.04' do
    let(:facts) { {'osfamily' => 'Debian', 'os' => { 'name' => 'Ubuntu', 'release' => {'full' => '16.04', 'major' => '16.04'}, 'distro' => {'codename' => 'xenial'}, 'family' => 'Debian'} }}
    let(:params) { { :deploy_key => "#{deploy_key}" } }

    it 'should compile' do should create_class('threatstack') end
    it { should contain_class('threatstack::package') }
    it { should contain_class('threatstack::configure') }
  end

  context 'on RedHat' do
    let(:facts) {  { 'operatingsystem' => 'RedHat', 'operatingsystemmajrelease' => '7', 'os' => { 'release' => { 'full' => '7.5', 'major' => '7', 'minor' => '5'}, 'name' => 'RedHat', 'family' => 'RedHat'} } }
    let(:params) { { :deploy_key => "#{deploy_key}" } }

    it 'should compile' do should create_class('threatstack') end
    it { should contain_class('threatstack::package') }
    it { should contain_class('threatstack::configure') }

  end

  context 'on CentOS' do
    let(:facts) { {'operatingsystem' => 'CentOS', 'operatingsystemmajrelease' => '7', 'os' => { 'release' => { 'full' => '7.4.1708', 'major' => '7', 'minor' => '4'}, 'name' => 'CentOS', 'family' => 'RedHat'} } }
    let(:params) { { :deploy_key => "#{deploy_key}" } }

    it 'should compile' do should create_class('threatstack') end
    it { should contain_class('threatstack::package') }
    it { should contain_class('threatstack::configure') }

  end

  context 'on Amazon' do
    let(:facts) {  {'operatingsystemmajrelease' => '2', 'os' => { 'name' => 'Amazon', 'family' => 'RedHat'} } }
    let(:params) { { :deploy_key => "#{deploy_key}" } }

    it 'should compile' do should create_class('threatstack') end
    it { should contain_class('threatstack::package') }
    it { should contain_class('threatstack::configure') }

  end



end

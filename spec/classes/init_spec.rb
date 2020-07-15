require 'spec_helper'

describe 'threatstack' do

  deploy_key = ENV['TS_DEPLOY_KEY'] ? ENV['TS_DEPLOY_KEY'] : "xKkRzesqg"

  context 'on Debian 8' do
      let(:facts) { {'lsbdistcodename' => 'jessie', :operatingsystem => 'Debian', :osfamily => 'Debian', 'os' => { 'family' => 'Debian', 'name' => 'Debian', 'release' => { 'full' => '8.11', 'major' => '8', 'minor' => '11'}, 'distro' => {'release' => { 'full' => '8.11', 'major' => '8', 'minor' => '11', 'codename' => 'jessie'}, 'family' => 'Debian'} } } }
    let(:params) { { :deploy_key => "#{deploy_key}" } }

    it 'should compile' do should create_class('threatstack') end
    it { should contain_class('threatstack::package') }
    it { should contain_class('threatstack::configure') }
  end

  context 'on Debian 9' do
    let(:facts) { {:operatingsystem => 'Debian', :osfamily => 'Debian', 'os' => { 'name' => 'Debian', 'release' => {'full' => '9.1', 'major' => '9', 'minor' => '1'}, 'distro' => {'codename' => 'stretch'}, 'family' => 'Debian'} } }
    let(:params) { { :deploy_key => "#{deploy_key}" } }

    it 'should compile' do should create_class('threatstack') end
    it { should contain_class('threatstack::package') }
    it { should contain_class('threatstack::configure') }
  end

  context 'on Debian 10' do
    let(:facts) { {:operatingsystem => 'Debian', :osfamily => 'Debian', 'os' => { 'name' => 'Debian', 'release' => {'full' => '10.4', 'major' => '10', 'minor' => '4'}, 'distro' => {'codename' => 'buster'}, 'family' => 'Debian'} } }
    let(:params) { { :deploy_key => "#{deploy_key}" } }

    it 'should compile' do should create_class('threatstack') end
    it { should contain_class('threatstack::package') }
    it { should contain_class('threatstack::configure') }
  end

  context 'on Ubuntu 20.04' do
    let(:facts) { {:osfamily => 'Debian', 'os' => { 'name' => 'Ubuntu', 'release' => {'full' => '20.04', 'major' => '20.04'}, 'distro' => {'codename' => 'focal'}, 'family' => 'Debian'} }}
    let(:params) { { :deploy_key => "#{deploy_key}" } }

    it 'should compile' do should create_class('threatstack') end
    it { should contain_class('threatstack::package') }
    it { should contain_class('threatstack::configure') }
  end

  context 'on Ubuntu 18.04' do
    let(:facts) { {:osfamily => 'Debian', 'os' => { 'name' => 'Ubuntu', 'release' => {'full' => '18.04', 'major' => '18.04'}, 'distro' => {'codename' => 'bionic'}, 'family' => 'Debian'} }}
    let(:params) { { :deploy_key => "#{deploy_key}" } }

    it 'should compile' do should create_class('threatstack') end
    it { should contain_class('threatstack::package') }
    it { should contain_class('threatstack::configure') }
  end

  context 'on Ubuntu 16.04' do
    let(:facts) { {:osfamily => 'Debian', 'os' => { 'name' => 'Ubuntu', 'release' => {'full' => '16.04', 'major' => '16.04'}, 'distro' => {'codename' => 'xenial'}, 'family' => 'Debian'} }}
    let(:params) { { :deploy_key => "#{deploy_key}" } }

    it 'should compile' do should create_class('threatstack') end
    it { should contain_class('threatstack::package') }
    it { should contain_class('threatstack::configure') }
  end

  context 'on RedHat 8' do
    let(:facts) {  { :osfamily => 'RedHat', :operatingsystem => 'RedHat', :operatingsystemrelease => '8.2.2004', 'operatingsystemmajrelease' => '8', 'os' => { 'release' => { 'full' => '8.2.2004', 'major' => '8', 'minor' => '2'}, 'name' => 'RedHat', 'family' => 'RedHat'} } }
    let(:params) { { :deploy_key => "#{deploy_key}" } }

    it 'should compile' do should create_class('threatstack') end
    it { should contain_class('threatstack::package') }
    it { should contain_class('threatstack::configure') }
  end

  context 'on RedHat 7' do
    let(:facts) {  { :osfamily => 'RedHat', :operatingsystem => 'RedHat', :operatingsystemrelease => '7.5', 'operatingsystemmajrelease' => '7', 'os' => { 'release' => { 'full' => '7.5', 'major' => '7', 'minor' => '5'}, 'name' => 'RedHat', 'family' => 'RedHat'} } }
    let(:params) { { :deploy_key => "#{deploy_key}" } }

    it 'should compile' do should create_class('threatstack') end
    it { should contain_class('threatstack::package') }
    it { should contain_class('threatstack::configure') }
  end

  context 'on CentOS 8' do
    let(:facts) {  { :osfamily => 'RedHat', :operatingsystem => 'CentOS', :operatingsystemrelease => '8.2.2004', 'operatingsystemmajrelease' => '8', 'os' => { 'release' => { 'full' => '8.2.2004', 'major' => '8', 'minor' => '2'}, 'name' => 'CentOS', 'family' => 'RedHat'} } }
    let(:params) { { :deploy_key => "#{deploy_key}" } }

    it 'should compile' do should create_class('threatstack') end
    it { should contain_class('threatstack::package') }
    it { should contain_class('threatstack::configure') }
  end

  context 'on CentOS 7' do
    let(:facts) { {:osfamily => 'RedHat', :operatingsystem => 'CentOS', :operatingsystemrelease => '7.4.1708', 'operatingsystemmajrelease' => '7', 'os' => { 'release' => { 'full' => '7.4.1708', 'major' => '7', 'minor' => '4'}, 'name' => 'CentOS', 'family' => 'RedHat'} } }
    let(:params) { { :deploy_key => "#{deploy_key}" } }

    it 'should compile' do should create_class('threatstack') end
    it { should contain_class('threatstack::package') }
    it { should contain_class('threatstack::configure') }
  end

  context 'on Amazon Linux 2' do
      let(:facts) { { :operatingsystem => 'Amazon', :osfamily => 'RedHat', :operatingsystemrelease => '2.0', 'operatingsystemmajrelease' => '2', 'os' => { 'name' => 'Amazon', 'family' => 'RedHat', 'release' => { 'major' => '2'}} } }
    let(:params) { { :deploy_key => "#{deploy_key}" } }

    it 'should compile' do should create_class('threatstack') end
    it { should contain_class('threatstack::package') }
    it { should contain_class('threatstack::configure') }
  end

  context 'on Amazon Linux 1' do
    let(:facts) { { :operatingsystem => 'Amazon', :osfamily => 'RedHat', :operatingsystemrelease => '2018', 'operatingsystemmajrelease' => '2018', 'os' => { 'name' => 'Amazon', 'family' => 'RedHat', 'release' => { 'major' => '2018'}} } }
    let(:params) { { :deploy_key => "#{deploy_key}" } }

    it 'should compile' do should create_class('threatstack') end
    it { should contain_class('threatstack::package') }
    it { should contain_class('threatstack::configure') }
  end
end

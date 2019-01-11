require 'spec_helper'

describe 'threatstack::package' do

  context 'on RedHat' do
    let(:facts) {  { 'operatingsystem' => 'RedHat', 'operatingsystemmajrelease' => '7', 'os' => { 'release' => { 'full' => '7.5', 'major' => '7', 'minor' => '5'}, 'name' => 'RedHat', 'family' => 'RedHat'} } }

    context 'package' do
      it { should contain_package('threatstack-agent').with_ensure('installed') }
    end
  end

  context 'on Debian 8' do
    let(:facts) { {'osfamily' => 'Debian', 'os' => { 'name' => 'Debian', 'release' => {'full' => '8.11', 'major' => '8', 'minor' => '11'}, 'distro' => {'codename' => 'jessie'}, 'family' => 'Debian'} } }

    context 'package' do
      it { should contain_package('threatstack-agent').with_ensure('installed') }
    end
  end

end

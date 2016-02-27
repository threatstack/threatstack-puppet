require 'spec_helper'

describe 'threatstack' do

  context 'on Debian' do
    let(:facts) { {:osfamily => 'Debian'} }
    let(:params) { { :deploy_key => 'something' } }

    it 'should compile' do should create_class('threatstack') end
    it { should contain_class('threatstack::package') }
    it { should contain_class('threatstack::configure') }

  end

  context 'on RedHat' do
    let(:facts) { {:osfamily => 'RedHat'} }
    let(:params) { { :deploy_key => 'something' } }

    it 'should compile' do should create_class('threatstack') end
    it { should contain_class('threatstack::package') }
    it { should contain_class('threatstack::configure') }

  end

  context 'on Amazon' do
    let(:facts) { {:osfamily => 'Amazon'} }
    let(:params) { { :deploy_key => 'something' } }

    it 'should compile' do should create_class('threatstack') end
    it { should contain_class('threatstack::package') }
    it { should contain_class('threatstack::configure') }

  end



end

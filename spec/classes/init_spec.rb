require 'spec_helper'

describe 'threatstack' do

  deploy_key = ENV['TS_DEPLOY_KEY'] ? ENV['TS_DEPLOY_KEY'] : "xKkRzesqg"

  context 'on Debian' do
    let(:facts) { {:osfamily => 'Debian'} }
    let(:params) { { :deploy_key => "#{deploy_key}" } }

    it 'should compile' do should create_class('threatstack') end
    it { should contain_class('threatstack::package') }
    it { should contain_class('threatstack::configure') }

  end

  context 'on RedHat' do
    let(:facts) { {:osfamily => 'RedHat'} }
    let(:params) { { :deploy_key => "#{deploy_key}" } }

    it 'should compile' do should create_class('threatstack') end
    it { should contain_class('threatstack::package') }
    it { should contain_class('threatstack::configure') }

  end

  context 'on Amazon' do
    let(:facts) { {:osfamily => 'Amazon'} }
    let(:params) { { :deploy_key => "#{deploy_key}" } }

    it 'should compile' do should create_class('threatstack') end
    it { should contain_class('threatstack::package') }
    it { should contain_class('threatstack::configure') }

  end
  context 'when creating an ami on Amazon linux' do
    let(:facts) { {:osfamily => 'Amazon', :operatingsystem => 'Amazon'} }
    let(:params) { { :deploy_key => "#{deploy_key}", :configure_agent => false } }

    it 'should compile' do should create_class('threatstack') end
    it { should contain_class('threatstack::package') }
    it { should_not contain_class('threatstack::configure') }
    it { should contain_file('/etc/cloud/cloud.cfg.d/99_threatstack.cfg').with_content(/--deploy-key=#{deploy_key}/) }
  end

end

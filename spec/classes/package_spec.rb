require 'spec_helper'

describe 'threatstack::package' do

  context 'on RedHat' do
    let(:facts) { {:osfamily => 'RedHat'} }
    let(:pre_condition) { 'include ::threatstack' }

    context 'package' do
      it { should contain_package('threatstack-agent').with_ensure('installed') }
    end
  end

  context 'on Debian' do
    let(:facts) { {:osfamily => 'Debian'} }
    let(:pre_condition) { 'include ::threatstack' }

    context 'package' do
      it { should contain_package('threatstack-agent').with_ensure('installed') }
    end
  end

end

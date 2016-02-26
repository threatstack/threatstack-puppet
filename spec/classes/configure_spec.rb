require 'spec_helper'

describe 'threatstack::configure' do

  context 'on Debian' do
    let(:facts) { {:osfamily => 'Debian'} }
    let(:pre_condition) { 'include ::threatstack' }

    it { should contain_exec('configure-threatstack-agent').with(
      :command => "/opt/threatstack/bin/cloudsight setup --deploy-key='xKkRzesqg' --hostname='test-host'  --ruleset='Default Ruleset'"
    )}
  end

end

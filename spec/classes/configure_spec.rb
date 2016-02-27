require 'spec_helper'

describe 'threatstack::configure' do

  context 'on Debian' do
    let(:facts) { {:osfamily => 'Debian'} }
    let(:pre_condition) { 'class { "threatstack": deploy_key => "xKkRzesqg", ruleset => ["Default Ruleset", "Service Ruleset"], ts_hostname => "test-host" }' }

    it { should contain_exec('configure-threatstack-agent').with(
      :command => "/opt/threatstack/bin/cloudsight setup --deploy-key='xKkRzesqg' --hostname='test-host'  --ruleset='Default Ruleset' --ruleset='Service Ruleset'"
    )}
  end

end

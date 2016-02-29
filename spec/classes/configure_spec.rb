require 'spec_helper'

describe 'threatstack::configure' do

  deploy_key = ENV['TS_DEPLOY_KEY'] ? ENV['TS_DEPLOY_KEY'] : "xKkRzesqg"

  context 'on Debian' do
    let(:facts) { {:osfamily => 'Debian'} }
    let(:pre_condition) { "class { 'threatstack': deploy_key => '#{deploy_key}' }" }

    it { should contain_exec('configure-threatstack-agent').with(
      :command => "/opt/threatstack/bin/cloudsight setup --deploy-key='#{deploy_key}' --hostname='test-host'  --ruleset='Default Ruleset' --ruleset='Service Ruleset'"
    )}
  end

end

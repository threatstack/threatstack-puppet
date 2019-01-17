require 'spec_helper'

describe 'threatstack::configure' do

  deploy_key = ENV['TS_DEPLOY_KEY'] ? ENV['TS_DEPLOY_KEY'] : "xKkRzesqg"
  feature_plan = ENV['TS_FEATURE_PLAN'] ? ENV['TS_FEATURE_PLAN'] : "monitor"
  ts_hostname = 'test-host'

  context 'on Debian 8' do
    let(:pre_condition) { "class { 'threatstack': deploy_key => '#{deploy_key}', ts_hostname => '#{ts_hostname}', rulesets => ['Default Ruleset', 'Service Ruleset'], agent_config_args => [{'log.level' => 'debug'}] }" }

    it { should contain_exec('threatstack-agent-setup').with(
      :command => "/usr/bin/tsagent setup --deploy-key='#{deploy_key}' --hostname='#{ts_hostname}' --ruleset Default Ruleset --ruleset Service Ruleset"
    )}
  end

  context 'on Debian 9' do
    let(:pre_condition) { "class { 'threatstack': deploy_key => '#{deploy_key}', ts_hostname => '#{ts_hostname}', rulesets => ['Default Ruleset', 'Service Ruleset'], agent_config_args => [{'log.level' => 'debug'}] }" }

    it { should contain_exec('threatstack-agent-setup').with(
      :command => "/usr/bin/tsagent setup --deploy-key='#{deploy_key}' --hostname='#{ts_hostname}' --ruleset Default Ruleset --ruleset Service Ruleset"
    )}
  end

  context 'on Ubuntu 18.04' do
    let(:pre_condition) { "class { 'threatstack': deploy_key => '#{deploy_key}', ts_hostname => '#{ts_hostname}', rulesets => ['Default Ruleset', 'Service Ruleset'], agent_config_args => [{'log.level' => 'debug'}] }" }

    it { should contain_exec('threatstack-agent-setup').with(
      :command => "/usr/bin/tsagent setup --deploy-key='#{deploy_key}' --hostname='#{ts_hostname}' --ruleset Default Ruleset --ruleset Service Ruleset"
    )}
  end

  context 'on Ubuntu 16.04' do
    let(:pre_condition) { "class { 'threatstack': deploy_key => '#{deploy_key}', ts_hostname => '#{ts_hostname}', rulesets => ['Default Ruleset', 'Service Ruleset'], agent_config_args => [{'log.level' => 'debug'}] }" }

    it { should contain_exec('threatstack-agent-setup').with(
      :command => "/usr/bin/tsagent setup --deploy-key='#{deploy_key}' --hostname='#{ts_hostname}' --ruleset Default Ruleset --ruleset Service Ruleset"
    )}
  end

  context 'on Ubuntu 14.04' do
    let(:pre_condition) { "class { 'threatstack': deploy_key => '#{deploy_key}', ts_hostname => '#{ts_hostname}', rulesets => ['Default Ruleset', 'Service Ruleset'], agent_config_args => [{'log.level' => 'debug'}] }" }

    it { should contain_exec('threatstack-agent-setup').with(
      :command => "/usr/bin/tsagent setup --deploy-key='#{deploy_key}' --hostname='#{ts_hostname}' --ruleset Default Ruleset --ruleset Service Ruleset"
    )}
  end

  context 'on Redhat' do
    let(:pre_condition) { "class { 'threatstack': deploy_key => '#{deploy_key}', ts_hostname => '#{ts_hostname}', rulesets => ['Default Ruleset', 'Service Ruleset'], agent_config_args => [{'log.level' => 'debug'}] }" }

    it { should contain_exec('threatstack-agent-setup').with(
      :command => "/usr/bin/tsagent setup --deploy-key='#{deploy_key}' --hostname='#{ts_hostname}' --ruleset Default Ruleset --ruleset Service Ruleset"
    )}
  end

  context 'on CentOS 7' do
    let(:pre_condition) { "class { 'threatstack': deploy_key => '#{deploy_key}', ts_hostname => '#{ts_hostname}', rulesets => ['Default Ruleset', 'Service Ruleset'], agent_config_args => [{'log.level' => 'debug'}] }" }

    it { should contain_exec('threatstack-agent-setup').with(
      :command => "/usr/bin/tsagent setup --deploy-key='#{deploy_key}' --hostname='#{ts_hostname}' --ruleset Default Ruleset --ruleset Service Ruleset"
    )}
  end

  context 'on Amazon Linux' do
    let(:pre_condition) { "class { 'threatstack': deploy_key => '#{deploy_key}', ts_hostname => '#{ts_hostname}', rulesets => ['Default Ruleset', 'Service Ruleset'], agent_config_args => [{'log.level' => 'debug'}] }" }

    it { should contain_exec('threatstack-agent-setup').with(
      :command => "/usr/bin/tsagent setup --deploy-key='#{deploy_key}' --hostname='#{ts_hostname}' --ruleset Default Ruleset --ruleset Service Ruleset"
    )}
  end

end

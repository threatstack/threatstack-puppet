require 'spec_helper'

describe 'threatstack::configure' do

  deploy_key = ENV['TS_DEPLOY_KEY'] ? ENV['TS_DEPLOY_KEY'] : "xKkRzesqg"
  ts_hostname = 'test-host'

  context 'on Debian 8' do
    let(:facts) { {'operatingsystem' => 'Debian', 'osfamily' => 'Debian', 'os' => { 'name' => 'Debian', 'release' => {'full' => '8.11', 'major' => '8', 'minor' => '11'}, 'distro' => {'codename' => 'jessie'}, 'family' => 'Debian'} } }
    let(:pre_condition) { "class { 'threatstack': deploy_key => '#{deploy_key}', ts_hostname => '#{ts_hostname}', rulesets => ['Default Ruleset', 'Service Ruleset'], agent_config_args => [{'log.level' => 'debug'}]}" }

    it { should contain_exec('threatstack-agent-setup').with(
      :command => "/usr/bin/tsagent setup --deploy-key='#{deploy_key}' --hostname='#{ts_hostname}' --ruleset='Default Ruleset' --ruleset='Service Ruleset'"
    )}
  end

  context 'on Debian 9' do
    let(:facts) { {'operatingsystem' => 'Debian', 'osfamily' => 'Debian', 'os' => { 'name' => 'Debian', 'release' => {'full' => '9.1', 'major' => '9', 'minor' => '1'}, 'distro' => {'codename' => 'stretch'}, 'family' => 'Debian'} } }
    let(:pre_condition) { "class { 'threatstack': deploy_key => '#{deploy_key}', ts_hostname => '#{ts_hostname}', rulesets => ['Default Ruleset', 'Service Ruleset'], agent_config_args => [{'log.level' => 'debug'}]}" }

    it { should contain_exec('threatstack-agent-setup').with(
      :command => "/usr/bin/tsagent setup --deploy-key='#{deploy_key}' --hostname='#{ts_hostname}' --ruleset='Default Ruleset' --ruleset='Service Ruleset'"
    )}
  end

  context 'on Ubuntu 18.04' do
    let(:facts) { {'osfamily' => 'Debian', 'os' => { 'name' => 'Ubuntu', 'release' => {'full' => '18.04', 'major' => '18.04'}, 'distro' => {'codename' => 'bionic'}, 'family' => 'Debian'} }}
    let(:pre_condition) { "class { 'threatstack': deploy_key => '#{deploy_key}', ts_hostname => '#{ts_hostname}', rulesets => ['Default Ruleset', 'Service Ruleset'], agent_config_args => [{'log.level' => 'debug'}]}" }

    it { should contain_exec('threatstack-agent-setup').with(
      :command => "/usr/bin/tsagent setup --deploy-key='#{deploy_key}' --hostname='#{ts_hostname}' --ruleset='Default Ruleset' --ruleset='Service Ruleset'"
    )}
  end

  context 'on Ubuntu 16.04' do
    let(:facts) { {'osfamily' => 'Debian', 'os' => { 'name' => 'Ubuntu', 'release' => {'full' => '16.04', 'major' => '16.04'}, 'distro' => {'codename' => 'xenial'}, 'family' => 'Debian'} }}
    let(:pre_condition) { "class { 'threatstack': deploy_key => '#{deploy_key}', ts_hostname => '#{ts_hostname}', rulesets => ['Default Ruleset', 'Service Ruleset'], agent_config_args => [{'log.level' => 'debug'}]}" }

    it { should contain_exec('threatstack-agent-setup').with(
      :command => "/usr/bin/tsagent setup --deploy-key='#{deploy_key}' --hostname='#{ts_hostname}' --ruleset='Default Ruleset' --ruleset='Service Ruleset'"
    )}
  end

  context 'on Redhat' do
    let(:facts) {  { 'operatingsystemmajrelease' => '7', 'os' => { 'release' => { 'major' => '7'}, 'name' => 'RedHat', 'family' => 'RedHat'} } }
    let(:pre_condition) { "class { 'threatstack': deploy_key => '#{deploy_key}', ts_hostname => '#{ts_hostname}', rulesets => ['Default Ruleset', 'Service Ruleset'], agent_config_args => [{'log.level' => 'debug'}]}" }

    it { should contain_exec('threatstack-agent-setup').with(
      :command => "/usr/bin/tsagent setup --deploy-key='#{deploy_key}' --hostname='#{ts_hostname}' --ruleset='Default Ruleset' --ruleset='Service Ruleset'"
    )}
  end

  context 'on CentOS 7' do
    let(:facts) { {'operatingsystemmajrelease' => '7', 'os' => { 'release' => { 'major' => '7'}, 'name' => 'CentOS', 'family' => 'RedHat'} } }
    let(:pre_condition) { "class { 'threatstack': deploy_key => '#{deploy_key}', ts_hostname => '#{ts_hostname}', rulesets => ['Default Ruleset', 'Service Ruleset'], agent_config_args => [{'log.level' => 'debug'}]}" }

    it { should contain_exec('threatstack-agent-setup').with(
      :command => "/usr/bin/tsagent setup --deploy-key='#{deploy_key}' --hostname='#{ts_hostname}' --ruleset='Default Ruleset' --ruleset='Service Ruleset'"
    )}
  end

  context 'on Amazon Linux 2' do
    let(:facts) {  {'operatingsystemmajrelease' => '2', 'os' => {  'release' => { 'major' => '2'}, 'name' => 'Amazon', 'family' => 'RedHat'} } }
    let(:pre_condition) { "class { 'threatstack': deploy_key => '#{deploy_key}', ts_hostname => '#{ts_hostname}', rulesets => ['Default Ruleset', 'Service Ruleset'], agent_config_args => [{'log.level' => 'debug'}]}" }

    it { should contain_exec('threatstack-agent-setup').with(
      :command => "/usr/bin/tsagent setup --deploy-key='#{deploy_key}' --hostname='#{ts_hostname}' --ruleset='Default Ruleset' --ruleset='Service Ruleset'"
    )}
  end

  context 'on Amazon Linux 1' do
    let(:facts) {  {'operatingsystemmajrelease' => '2018', 'os' => {  'release' => { 'major' => '2018'}, 'name' => 'Amazon', 'family' => 'RedHat'} } }
    let(:pre_condition) { "class { 'threatstack': deploy_key => '#{deploy_key}', ts_hostname => '#{ts_hostname}', rulesets => ['Default Ruleset', 'Service Ruleset'], agent_config_args => [{'log.level' => 'debug'}]}" }

    it { should contain_exec('threatstack-agent-setup').with(
      :command => "/usr/bin/tsagent setup --deploy-key='#{deploy_key}' --hostname='#{ts_hostname}' --ruleset='Default Ruleset' --ruleset='Service Ruleset'"
    )}
  end

end

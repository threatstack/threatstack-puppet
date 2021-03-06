require 'serverspec'

set :backend, :exec

describe package('threatstack-agent') do
  it { should be_installed }
end

# Work around old service system in Amazon Linux 1
if os[:family] == 'amazon' && os[:release] != "2"

  describe command('sudo initctl status threatstack') do
    its(:stdout) { should match /threatstack start\/running/ } # rubocop: disable Lint/AmbiguousRegexpLiteral
  end

  describe service('threatstack') do
    it { should be_enabled }
  end
else
  describe service('threatstack') do
    it { should be_running }
    it { should be_enabled }
  end
end

describe command('tsagent status') do
  # Sometimes due to other services, like auditd, the install would be successful, but then this service would get killed
  its(:stdout) { should match /UP Threat Stack Agent Daemon/ } # rubocop: disable Lint/AmbiguousRegexpLiteral
  its(:stdout) { should match /UP Threat Stack Backend Connection/ } # rubocop: disable Lint/AmbiguousRegexpLiteral
  its(:stdout) { should match /UP Threat Stack Heartbeat Service/ } # rubocop: disable Lint/AmbiguousRegexpLiteral
  its(:stdout) { should match /UP Threat Stack Login Collector/ } # rubocop: disable Lint/AmbiguousRegexpLiteral
  its(:stdout) { should match /UP Threat Stack Log Scan Service/ } # rubocop: disable Lint/AmbiguousRegexpLiteral
  its(:stdout) { should match /UP Threat Stack Vulnerability Scanner/ } # rubocop: disable Lint/AmbiguousRegexpLiteral
  its(:stdout) { should match /UP Threat Stack File Integrity Monitor/ } # rubocop: disable Lint/AmbiguousRegexpLiteral
end

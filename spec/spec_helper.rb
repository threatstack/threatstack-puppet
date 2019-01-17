require 'rspec-puppet'
require 'puppetlabs_spec_helper/puppetlabs_spec_helper'
require 'puppetlabs_spec_helper/module_spec_helper'
require 'rspec-puppet-facts'

include RspecPuppetFacts

fixture_path = File.expand_path(File.join(__FILE__, '..', 'fixtures'))

RSpec.configure do |c|
  c.module_path = File.join(fixture_path, 'modules')
  c.manifest_dir = File.join(fixture_path, 'manifests')
  c.parser = 'future' if Puppet.version.to_f >= 4.0
  c.environmentpath = File.expand_path(File.join(Dir.pwd, 'spec')) if Puppet.version.to_f >= 4.0
  c.mock_with :rspec
end

at_exit { RSpec::Puppet::Coverage.report! }

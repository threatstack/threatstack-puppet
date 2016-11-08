require 'rspec-puppet'
require 'puppetlabs_spec_helper/puppetlabs_spec_helper'

fixture_path = File.expand_path(File.join(__FILE__, '..', 'fixtures'))

RSpec.configure do |c|
  c.module_path = File.join(fixture_path, 'modules')
  c.manifest_dir = File.join(fixture_path, 'manifests')
  c.parser = 'future' if ENV['PARSER'] == 'future'
  c.environmentpath = File.expand_path(File.join(Dir.pwd, 'spec')) if Puppet.version.to_f >= 4.0
end

at_exit { RSpec::Puppet::Coverage.report! }

source 'https://rubygems.org'

source ENV['GEM_SOURCE'] || 'https://rubygems.org'

group :development, :unit_tests do
  gem 'rake',                        :require => false
  gem 'rspec-puppet', "2.2.0",       :require => false
  gem 'puppetlabs_spec_helper',      :require => false
  gem 'puppet-lint', "1.0.1",        :require => false
  gem 'librarian-puppet',            :require => false
  gem 'simplecov',                   :require => false
  gem 'json',                        :require => false
  gem 'puppet-syntax',               :require => false
  gem 'metadata-json-lint', '0.0.4', :require => false
  gem 'vagrant-wrapper',             :require => false
  gem 'puppet-blacksmith',           :require => false
  gem 'rest-client', ">=1.7.3",      :require => false
end
group :system_tests do
  gem 'serverspec',      :require => false
  gem 'test-kitchen',    :require => false
  gem 'kitchen-puppet',  :require => false
  gem 'kitchen-vagrant', :require => false
end

if facterversion = ENV['FACTER_GEM_VERSION']
  gem 'facter', facterversion, :require => false
else
  gem 'facter', :require => false
end

if puppetversion = ENV['PUPPET_VERSION']
  gem 'puppet', puppetversion, :require => false
else
  gem 'puppet', '3.8.2', :require => false
end

# vim:ft=ruby

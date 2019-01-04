require 'puppetlabs_spec_helper/rake_tasks'
require 'puppet-lint/tasks/puppet-lint'
require 'puppet-syntax/tasks/puppet-syntax'

exclude_paths = [
  'pkg/**/*',
  'vendor/**/*',
  'spec/**/*',
  'pkg/**/*',
]

# PuppetLint.configuration.log_format = '%{path}:%{linenumber}:%{check}:%{KIND}:%{message}'
PuppetLint.configuration.ignore_paths = exclude_paths
PuppetLint.configuration.send('disable_80chars')
PuppetLint.configuration.send('disable_autoloader_layout')
PuppetSyntax.exclude_paths = exclude_paths

task :metadata do
  sh 'metadata-json-lint metadata.json'
end

desc 'Run syntax, lint, and spec tests.'
task :test => [
  :syntax,
  :lint,
  :metadata_lint,
  :spec,
]

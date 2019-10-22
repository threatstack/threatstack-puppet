Threat Stack Puppet Module
================

[![Build Status](https://travis-ci.org/threatstack/threatstack-puppet.svg?branch=master)][travis]
[![Puppet Forge](http://img.shields.io/puppetforge/v/threatstack/threatstack.svg)][module]

[travis]: https://travis-ci.org/threatstack/threatstack-puppet
[module]: https://forge.puppetlabs.com/threatstack/threatstack

Puppet manifests to deploy the Threat Stack server agent.

Threat Stack is a continuous cloud security monitoring service. It aims to provide an organization greater security, compliance, and operational efficiency.  Threat Stack customers can use this module to deploy the agent and register hosts.

For more see https://www.threatstack.com.

Platforms
---------

* Amazon Linux 2
* CentOS
* Debian
* RedHat
* Ubuntu
* Windows

Classes
=======

* `threatstack` - Main class
* `threatstack::apt` (private) - Setup apt repository configuration and package install
* `threatstack::yum` (private) - Setup yum repository configuration and package install
* `threatstack::msi` (private) - Dummy repo class for Windows installs
* `threatstack::configure` (private) - Register and configure the agent with the Threat Stack service
* `threatstack::package` (private) - Install the Threat Stack agent
* `threatstack::service` (private) - Manage the Threat Stack service
* `threatstack::params` (private) - Default setup values
* `threatstack::site` (private) - Used by Puppet test-kitchen

Parameters
=====

* `threatstack::deploy_key` [required] - Set the deploy key for registering the agent.
* `threatstack::rulesets` [optional array] - Set the ruleset or rulesets the node will be added to (Default: 'Base Rule Set').
* `threatstack::configure_agent` [optiona bool] - Set to false to just install agent without configuring. Useful for image building.
* `threatstack::agent_config_args` [optional array of hashes] - Extra arguments to pass during agent activation. Useful for enabling new platform features.
* `threatstack::disable_auditd` [optional bool] - Disable `auditd` service to avoid installation issues. (Default is 'true' on RHEL-like OSes.)
* `threatstack::disable_auditd_cmd` [optional string] - related to `threatstack::disable_auditd`, the OS version dependent command to disable auditd (Default: set in `threatstack::params` based on operating system)
* `threatstack::extra_args` [optional array of hashes] - optional array of hashes to define setup options for the threatstack agent (Default: `undef`)
* `threatstack::confdir` [optional string] - path to config directory for the threatstack service (Default: '/opt/threatstack/etc')
* `threatstack::ts_hostname` [optional string] - hostname of your node (Default: `$::fqdn`)
* `threatstack::gpg_key` [optional string] - gpg key url for use with yum/apt repos (Default: set in `threatstack::params` based on operating system)
* `threatstack::package_version` [optional string] - version of the `threatstack-agent` package to install (Default: `installed`)
* `threatstack::repo_class` [optional string] - name of puppet class that configures the threatstack package repo (Default: either `threatstack::apt` or `threatstack::yum`, set in `threatstack::params` based on operating system)
* `threatstack::repo_url` [optional string] - url used by threatstack package repo (Default: defined in `threatstack::params` for Debian and RedHat operating system families.)

Example usage
=====
Below are some examples for how to use this module.

Standard usage
===
Supply your Threat Stack deploy key, and if you choose, an array of rulesets.
```
class { '::threatstack':
  deploy_key    => 'MyDeployKey',
  ruleset       => ['MyRuleset']
}
```
Using a package mirror
===
If you manage your own package repository from which you deploy the agent package then supply `repo_url` and `gpg_key`.
```
class { '::threatstack':
  deploy_key    => 'MyDeployKey',
  ruleset       => ['MyRuleset'],
  repo_url      => 'https://my-mirror.example.com/centos-6'
  gpg_key       => 'https://my-mirror.example.com/RPM-GPG-KEY-THREATSTACK'
}
```

Agent installation into golden image
===
If installing the agent into an image that will be deployed for multiple instances, configure the class to not configure the agent while creating the image.  If the agent is registered and configured in the golden image then events and alerting will not be correct.
```
class { '::threatstack':
  configure_agent => false,
}
```

Testing
=======
Run the following to perform basic spec testing.
```
bundle install
bundle exec rake spec
```

Integration testing requires setting `TS_DEPLOY_KEY` in the environment to a valid key value for tests to succeed.
```
export TS_DEPLOY_KEY='<deploy_key>'
bundle exec kitchen test
```

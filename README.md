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

* Amazon Linux
* CentOS
* RedHat
* Ubuntu

Classes
=======

* `threatstack` - Main class
* `threatstack::apt` - Setup apt repository configuration and package install
* `threatstack::yum` - Setup yum repository configuration and package install
* `threatstack::configure` - Register and configure the agent with the Threat Stack service

Parameters
=====

* `threatstack::deploy_key` [required] - Set the deploy key for registering the agent
* `threatstack::ruleset` [optional array] - Set the ruleset or rulesets the node will be added to (Defaults to 'Base Rule Set')

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


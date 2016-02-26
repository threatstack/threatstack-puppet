Threat Stack Puppet Module
================

[![Build Status](https://travis-ci.org/threatstack/threatstack-chef.svg?branch=master)][travis]
[![Puppet Forge](http://img.shields.io/puppetforge/v/threatstack/threatstack.svg)][module]

[travis]: https://travis-ci.org/threatstack/threatstack-puppet
[module]: https://forge.puppetlabs.com/threatstack/threatstack

Puppet manifests to deploy the Threat Stack server agent

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

To test setup a site.pp in the manifests folder with your deploy key (and optional ruleset &/or hostname)
```
include ::stdlib

class { 'threatstack':
  deploy_key => 'xKkRzesqgkNPGwNNkmx4zHqTYCTUidDdMmNfcZqbxRLWLs3VyE',
  ruleset => ['Default Ruleset'],
  ts_hostname => 'My-server-1'
}
```

Then run:
```
bundle install
bundle exec kitchen test
```

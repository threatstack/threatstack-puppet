Threat Stack Puppet Module
================

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
* `threatstack::policy` [optional] - Set the policy the node will be added to (Defaults to 'Default Policy')

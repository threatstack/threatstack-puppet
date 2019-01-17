# Change log

We'll track changes here starting with details about the 2.0 release and reference to earlier releases.

## 2.0
### This release tracks the release of the Threat Stack Agent 2.0

### NOTE: To install/configure/run Threat Stack Agent < 2.0, please keep using the 1.8.1 release of this module. Module version 2.0 supports Threat Stack Agent 2.0 and above, only.

### Changed
- module depends on [puppetlabs/apt](https://github.com/puppetlabs/puppetlabs-apt) and [puppetlabs/stdlib](https://github.com/puppetlabs/puppetlabs-stdlib)
- paths and `tsagent` related commands are changed to reflect new layout in packages
- dropped support for TS Agent < 2.0 in this module
- agent package repos are completely separate
- supported OSes:
  - Debian 8, 9
  - Ubuntu 16.04, 18.04
  - RedHat 7
  - CentOS 7
  - Amazon Linux
- targets support for Puppet 5.x


### Fixed
- cleaned up code
- used `apt_source` resource instead of `exec`s
- updated spec tests

## 1.8.1

### Fixed
- use `operatingsystem` fact to ensure Amazon Linux can install yum repos


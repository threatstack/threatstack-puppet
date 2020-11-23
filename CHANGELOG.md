# Change log

We'll track changes here starting with details about the 2.0 release and reference to earlier releases.

## 2.0.11
- switched to using [simp/auditd](https://forge.puppet.com/modules/simp/auditd) to deal with `auditd`
  - the [kemra102/auditd](https://forge.puppet.com/modules/kemra102/auditd) module appears to be abandoned and doesn't support RHEL 8

## 2.0.10
### Added
- updated README with support for
  - Debian 10
  - Ubuntu 20.04
  - CentOS/RedHat 8
- updated tests for newer distros
- added optional parameter to enable/disable yum repo on rhel

## 2.0.9
### Fixed
- merged PR simplifying ruleset args
  - https://github.com/threatstack/threatstack-puppet/pull/47

## 2.0.8
### Fixed
- merged PR fixing amazon linux 1/upstart service compatibility
- also uses `remote_file` vs. `file` resource in windows manifest
  - https://github.com/threatstack/threatstack-puppet/pull/45
- merged PR defaulting to default apt keyserver
  - https://github.com/threatstack/threatstack-puppet/pull/46
- thanks @carthik and @amlodzianowski!

## 2.0.7
### Changed
- use a service resource to manage auditd vs. an exec

## 2.0.6
### Added
- added basic support for downloading, configuring, installing, running windows agent

## 2.0.2
### Fixed
- fixed amazon linux 1 support and tests

## 2.0.1
### Changed
- added optional parameter `disable_auditd` to handle issues users reported installing on RHEL-like OSes

### Fixed
- fixed amazon linux 2 yum repo assignment

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


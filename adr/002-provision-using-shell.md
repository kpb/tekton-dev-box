# Provision Using Shell

## Status

Updated. 11 March 2021
Accepted. 20 February 2021

## Context

[Vagrant][vagrant] supports a wide variety of provisioners, including: Ansible, Puppet, Chef, Salt, or Shell for
configuring a virtual machine.

## Decision

The provisioners Vagrant supports are very powerful, and I/Kenneth gravitate towards Ansible. Currently, the project is
straight forward enough to use the Shell. Keep it simple.

## Consequences

The project is easy to understand, and if someone so desires, they can add additional provisioners for more complex tasks.

[vagrant]: https://www.vagrantup.com/ "Vagrant"

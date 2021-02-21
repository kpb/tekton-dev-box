# Provision Using Shell

## Status

Accepted. 20 February 2021

## Context

[Vagrant][vagrant] supports a wide variety of provisioners, including: Ansible, Puppet, Chef, Salt, or Shell for
configuring a virtual machine.

## Decision

Many of the provisioners are very powerful, and I/Kenneth gravitate towards Ansible, the project is straight forward
enough to use the Shell. Keep it simple.

## Consequences

The project is easy to understand, and if someone so desires, they can add additional provisioners for more complex tasks.

[vagrant]: https://www.vagrantup.com/ "Vagrant"

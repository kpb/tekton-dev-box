# Ubuntu Tekton Development Box

## What is this?

A [Vagrant][vagrant] box for [Tekton][tekton] pipeline development, exploration, and demoing. Built on
[Ubuntu][ubuntu] 20.04. Uses [KinD][kind] to create a [Kubernetes][k8s] cluster and installs [Tekton][tekton].

## Prerequisites

- [Vagrant][vagrant]. Currently using version 2.2.14
- [VirtualBox][virtbox] 6.1
- [Vagrant][vagrant] [vagrant-vbguest][vbguest] plugin

### Running

1. Clone this repo:

```bash
$ git clone https://github.com/kpb/tekton-dev-box.git
$ cd tekton-dev-box
```

2. Create and Provision the [Vagrant][vagrant] Box

```bash
$ vagrant up
... can take a bit to download the box, configure K8s, and install Tekton (mine takes around 4.5 mins)
```
3. Create and Run a [Tekton][tekton] Task

```bash
$ kubectl apply -f task-hello.yaml
$ tkn task start hello && tkn taskrun logs --last -f
```

### What else is here?

The `adr` directory contains so-called [Architecture Decision Records][adr] documenting why the project is put together
the way it is.

Hope you find this useful! Peace.


<!-- refs -->

[adr]: https://cognitect.com/blog/2011/11/15/documenting-architecture-decisions "adder's"
[ubuntu]: https://ubuntu.com/
[k8s]: https://kubernetes.io "K8s Homepage"
[kind]: https://kind.sigs.k8s.io/ "KinD Homepage"
[tekton]: https://tekton.dev "Tekton Homepage"
[vagrant]: https://www.vagrantup.com/ "Vagrant Homepage"
[vbguest]: https://github.com/dotless-de/vagrant-vbguest "vbguest github page"
[virtbox]: https://www.virtualbox.org/ "Virtual Box Homepage"

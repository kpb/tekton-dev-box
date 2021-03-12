# Ubuntu Tekton Development Box

## What is this?

A [Vagrant][vagrant] box for [Tekton][tekton] pipeline development, exploration, and demoing. Built on
[Ubuntu][ubuntu] 20.04. Uses [KinD][kind] to create a [Kubernetes][k8s] cluster and installs [Tekton][tekton].

## Prerequisites

- [Vagrant][vagrant]. Currently using version 2.2.14
- [VirtualBox][virtbox] 6.1

### Nice to have
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
... can take several minutes to download the box, configure K8s, and install Tekton
```
3. Create and Run a [Tekton][tekton] Task

```bash
$ vagrant ssh
$ kubectl apply -f task-hello.yaml
$ tkn task start hello && tkn taskrun logs --last -f
```

#### Increase number of KinD nodes

If you'd like to have additional [KinD][kind] nodes, you can edit the `provision/create-kind-cluster.sh` file and
uncomment the `#- role: worker` line(s).

#### NGINX Ingress

The [KinD][kind] cluster is configured to use [NGINX Ingress][nginx-ingress], which you might want to use in developing
a pipeline. You can try it out with an example provided by KinD (see [KinD Using Ingress][kind-ingress]).

```bash
$ kubectl apply -f https://kind.sigs.k8s.io/examples/ingress/usage.yaml
```

Verify ingress works

```bash
$ curl localhost/foo
foo
$ curl localhost/bar
bar
```

### Tekton Dashboard

The Tekton dashboard is installed, ingress configured, and port 8080 is forwarded to the box. You can access the
dashboard at [localhost:8080](localhost:8080).

### What else is here?

The `adr` directory contains so-called [Architecture Decision Records][adr] documenting why the project is put together
the way it is.

Hope you find this useful! Peace.


<!-- refs -->

[adr]: https://cognitect.com/blog/2011/11/15/documenting-architecture-decisions "adder's"
[k8s]: https://kubernetes.io "K8s Homepage"
[kind-ingress]: https://kind.sigs.k8s.io/docs/user/ingress/#ingress-nginx
[kind]: https://kind.sigs.k8s.io/ "KinD Homepage"
[nginx-ingress]: https://kubernetes.github.io/ingress-nginx/
[tekton]: https://tekton.dev "Tekton Homepage"
[ubuntu]: https://ubuntu.com/
[vagrant]: https://www.vagrantup.com/ "Vagrant Homepage"
[vbguest]: https://github.com/dotless-de/vagrant-vbguest "vbguest github page"
[virtbox]: https://www.virtualbox.org/ "Virtual Box Homepage"

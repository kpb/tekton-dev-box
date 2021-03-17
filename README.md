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
dashboard at [localhost:8080](localhost:8080) from a browser on the host.

### Local Registry

A local registry is created and the KinD cluster configured to use it. From the [KinD Local
Registry][kind-local-registry] documentation, you can run an example like:

```bash
$ docker pull gcr.io/google-samples/hello-app:1.0
1.0: Pulling from google-samples/hello-app
b56ae66c2937: Pull complete 
68cbeea01567: Pull complete 
Digest: sha256:c62ead5b8c15c231f9e786250b07909daf6c266d0fcddd93fea882eb722c3be4
Status: Downloaded newer image for gcr.io/google-samples/hello-app:1.0
gcr.io/google-samples/hello-app:1.0

$ docker tag gcr.io/google-samples/hello-app:1.0 localhost:5000/hello-app:1.0
$ docker push localhost:5000/hello-app:1.0
The push refers to repository [localhost:5000/hello-app]
3b8ca1afdf65: Pushed 
2aebd096e0e2: Pushed 
1.0: digest: sha256:c62ead5b8c15c231f9e786250b07909daf6c266d0fcddd93fea882eb722c3be4 size: 739

$ kubectl create deployment hello-server --image=localhost:5000/hello-app:1.0
deployment.apps/hello-server created

$ kubectl get pods -o wide
NAME                            READY   STATUS    RESTARTS   AGE   IP           NODE                 NOMINATED NODE   READINESS GATES
hello-server-64679d86dd-dvgnd   1/1     Running   0          14s   10.244.0.8   kind-control-plane   <none>           <none>
```

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

[kind-local-registry]: https://kind.sigs.k8s.io/docs/user/local-registry/

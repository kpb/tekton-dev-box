# Use Docker

## Status

Accepted. 20 February 2021.

## Context

[Kubernetes in Docker (kind)][kind] requires a container engine. Currently, the choices are between [Docker
Engine][docker-ce] and the daemonless [Podman][podman].

## Decision

While I would prefer to use [Podman][podman], [Docker][docker-ce] is better supported by [KinD][kind] - can be easily
run as a non-root user.

## Consequences

[Podman][podman] is certainly the future, and the project should plan to upgrade to it once it is fully supported by
[Kind][kind].

<!-- refs -->

[docker-ce]: https://docs.docker.com/engine/ "Docker Engine"
[kind]: https://kind.sigs.k8s.io/ "KinD"
[podman]: https://podman.io/ "Podman"

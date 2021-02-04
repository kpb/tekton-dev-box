#!/usr/bin/env bash
set -e

vagrant_bin=/home/vagrant/bin

mkdir -p $vagrant_bin
curl -Lo $vagrant_bin/kind https://kind.sigs.k8s.io/dl/v0.10.0/kind-linux-amd64
chmod 755 $vagrant_bin/kind

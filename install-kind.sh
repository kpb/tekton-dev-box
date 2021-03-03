#!/usr/bin/env bash
set -e

# created in set up script
vagrant_bin=/home/vagrant/bin

curl -Lo $vagrant_bin/kind https://kind.sigs.k8s.io/dl/v0.10.0/kind-linux-amd64
chmod 755 $vagrant_bin/kind

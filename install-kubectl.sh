#!/usr/bin/env bash
set -e

vagrant_bin=/home/vagrant/bin

mkdir -p $vagrant_bin
curl -Lo ${vagrant_bin}/kubectl "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod 755 ${vagrant_bin}/kubectl

# checksum
curl -Lo ${vagrant_bin}/kubectl.sha256 "https://dl.k8s.io/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"
echo "$(<${vagrant_bin}/kubectl.sha256) ${vagrant_bin}/kubectl" | sha256sum --check

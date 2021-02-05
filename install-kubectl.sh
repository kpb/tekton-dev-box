#!/usr/bin/env bash
set -e

# created in setup script
vagrant_bin=/home/vagrant/bin

curl -Lo ${vagrant_bin}/kubectl "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chown vagrant:vagrant ${vagrant_bin}/kubectl
chmod 755 ${vagrant_bin}/kubectl

# verify checksum
curl -Lo ${vagrant_bin}/kubectl.sha256 "https://dl.k8s.io/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"
echo "$(<${vagrant_bin}/kubectl.sha256) ${vagrant_bin}/kubectl" | sha256sum --check

#!/usr/bin/env bash
#
# See https://tekton.dev/docs/getting-started/ for details
set -e

vagrant_bin=/home/vagrant/bin
kind_cmd=${vagrant_bin}/kind
kubectl_cmd=${vagrant_bin}/kubectl

$kind_cmd create cluster --wait 10m

$kubectl_cmd apply --filename https://storage.googleapis.com/tekton-releases/pipeline/latest/release.yaml

echo "Waiting for tekton-pipelines pods to be available"
$kubectl_cmd wait --namespace tekton-pipelines --timeout=-30s --for=condition=Ready pods --all

# Install tekton cli
curl -Lo tkn.tar.gz https://github.com/tektoncd/cli/releases/download/v0.16.0/tkn_0.16.0_Linux_x86_64.tar.gz
tar zxvf tkn.tar.gz -C ./bin tkn
rm tkn.tar.gz
chmod 755 ./bin/tkn

# Configure pvc
$kubectl_cmd create configmap config-artifact-pvc \
        --from-literal=size=10Gi \
        --from-literal=storageClassName=manual \
        -o yaml -n tekton-pipelines \
        --dry-run=client | $kubectl_cmd replace -f -

#!/usr/bin/env bash
#
# See https://tekton.dev/docs/getting-started/ for details
set -e

vagrant_bin=/home/vagrant/bin
kind_cmd=${vagrant_bin}/kind
kubectl_cmd=${vagrant_bin}/kubectl

$kind_cmd create cluster

$kubectl_cmd apply --filename https://storage.googleapis.com/tekton-releases/pipeline/latest/release.yaml

echo "Waiting for tekton-pipelines-controller pod to be available..."
until $kubectl_cmd wait --namespace tekton-pipelines --timeout=-1s --for=condition=Ready --selector app=tekton-pipelines-controller pod
do
    echo "...still waiting"
    sleep 3
done

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

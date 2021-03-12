#!/usr/bin/env bash
#
# See https://tekton.dev/docs/getting-started/ for details
set -e
set -x

vagrant_bin=/home/vagrant/bin
kubectl_cmd=${vagrant_bin}/kubectl

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

# Install the Dashboard
$kubectl_cmd apply --filename https://github.com/tektoncd/dashboard/releases/latest/download/tekton-dashboard-release.yaml

echo "Waiting for Dashboard pods to be available"
$kubectl_cmd wait --namespace tekton-pipelines --timeout=-30s --for=condition=Ready pods --all

# Ingress for the dashboard
cat <<EOF | $kubectl_cmd apply -f -
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: tekton-dashboard-ingress
  namespace: tekton-pipelines
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /
spec:
  rules:
  - http:
      paths:
        - path: /
          pathType: Prefix
          backend:
            service:
              name: tekton-dashboard
              port:
                number: 9097
EOF

#!/bin/bash

kubectl get no --show-labels

kubectl run ssd-pod --context=kind-kind --image=nginx --dry-run=client -o yaml > ssd-pod.yaml

kubectl label no kind-worker disktype=ssd

cat <<EOF | kubectl apply -f -
kind: Cluster
apiVersion: v1
nodes:
- role: control-plane
- role: worker
- role: worker
EOF
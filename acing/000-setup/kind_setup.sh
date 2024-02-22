#!/bin/bash

# install kind
curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.22.0/kind-darwin-arm64
# add  /Users/uditabose/go/bin  to PATH

# create cluster
kind create cluster

# view cluster
kubectl cluster-info --context kind-kind                                                                                                             [20:52:17]
## Kubernetes control plane is running at https://127.0.0.1:54486
## CoreDNS is running at https://127.0.0.1:54486/api/v1/namespaces/kube-system/services/kube-dns:dns/proxy
## 
## To further debug and diagnose cluster problems, use 'kubectl cluster-info dump'. 

kind delete cluster

## multi-node cluster
kind create cluster --config config.yaml --name acing  

kind delete cluster --name  kind-acing

## advanced nodes
kind create cluster --config config_advanced.yaml --name acing-advanced
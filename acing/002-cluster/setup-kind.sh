#!/bin/bash

# step 1: install xcode
# ----------------------------
xcode-select --install


# step 2: install KIND cluster
# ----------------------------
# details: https://kind.sigs.k8s.io/docs/user/quick-start/
# docs: https://github.com/kubernetes-sigs/kind
# add to PATH
go install sigs.k8s.io/kind@v0.17.0 && kind create cluster

<<output
 kind create cluster                                                                              
Creating cluster "kind" ...
 ✓ Ensuring node image (kindest/node:v1.25.3) 🖼 aqx
 ✓ Preparing nodes 📦
 ✓ Writing configuration 📜
 ✓ Starting control-plane 🕹️
 ✓ Installing CNI 🔌
 ✓ Installing StorageClass 💾
Set kubectl context to "kind-kind"
You can now use your cluster with:

kubectl cluster-info --context kind-kind

Have a nice day! 👋
output



# step 3: valiadet KIND
# ----------------------------
kubectl get po -n kube-system

#-----------------------------
<<output
NAME                                         READY   STATUS    RESTARTS   AGE
coredns-565d847f94-6kvg7                     1/1     Running   0          2m18s
coredns-565d847f94-x6nhp                     1/1     Running   0          2m18s
etcd-kind-control-plane                      1/1     Running   0          2m30s
kindnet-p9kz7                                1/1     Running   0          2m19s
kube-apiserver-kind-control-plane            1/1     Running   0          2m30s
kube-controller-manager-kind-control-plane   1/1     Running   0          2m30s
kube-proxy-gvsl4                             1/1     Running   0          2m19s
kube-scheduler-kind-control-plane            1/1     Running   0          2m30s
comment



# step 4: details of KIND
# ----------------------------
kubectl cluster-info dump > acing/002-cluster/kind-cluster-dump.txt      
kubectl cluster-info --context kind-kind 

#-----------------------------
<<comment
Kubernetes control plane is running at https://127.0.0.1:61386
CoreDNS is running at https://127.0.0.1:61386/api/v1/namespaces/kube-system/services/kube-dns:dns/proxy
output



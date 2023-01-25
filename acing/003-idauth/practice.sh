#!/bin/bash

# create a role
kubectl create role pod-reader --verb=get,list,watch --resource=pods
kubectl get role pod-reader -o yaml | more

kubectl create rolebinding pod-reader-binding --role=pod-reader --user=carol
kubectl get rolebinding pod-reader-binding -oyaml
kubectl auth can-i
kubectl auth can-i get pods -n default --as carol
kubectl get clusterrole
kubectl auth can-i --list
kubectl get clusterrolebinding cluster-admin -o yaml

openssl genrsa -out carol.key 2048
openssl req -new -key carol.key -subj "/CN=carol/O=developers" -out carol.csr
cat carol.csr | base64 -w 0

export REQUEST=$(cat carol.csr | base64 -w 0)

cat <<EOF | kubectl apply -f -
apiVersion: certificates.k8s.io/v1
kind: CertificateSigningRequest
metadata:
  name: carol
spec:
  groups:
  - developers
  request: $REQUEST
  signerName: kubernetes.io/kube-apiserver-client
  usages:
  - client auth
EOF

kubectl apply -f https://raw.githubusercontent.com/chadmcrowell/k8s/main/manifests/csr-carol.yaml

kubectl get csr
kubectl certificate approve carol

kubectl get csr carol -o jsonpath='{.status.certificate}' | base64 -d > carol.crt

kubectl config set-credentials carol --client-key=carol.key --client-certificate=carol.crt --embed-certs
kubectl config view


kubectl config set-context carol --user=carol --cluster=kind

kubectl config get-contexts

kubectl config use-context carol
kubectl get po

kubectl config use-context kubernetes-admin@kind
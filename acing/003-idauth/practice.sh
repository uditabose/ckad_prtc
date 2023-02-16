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

kubectl delete rolebinding admin-binding

kubectl create rolebinding pod-reader-bind --role=pod-reader --group=developers

kubectl config use-context carol
kubectl get po

kubectl create ns web
kubectl get sa -n web
kubectl describe secret -n web
kubectl describe sa -n web
kubectl describe secret default-token-mv8xd -n web

kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.7.0/aio/deploy/recommended.yaml
kubectl apply -f https://k8s.io/examples/application/deployment.yaml

kubectl get po nginx -o yaml

kubectl exec -it nginx-deployment-7fb96c846b-77kfv -- sh
cat /var/run/secrets/kubernetes.io/serviceaccount/token

kubectl create sa nomount-sa --dry-run=client -o yaml > nomount-sa.yaml
echo "automountServiceAccountToken: false" >> nomount-sa.yaml
kubectl create -f nomount-sa.yaml
kubectl run no-mount --image nginx --dry-run=client -o yaml > no-mount-pod.yaml
apt update && apt install -y vim

kubectl create -f no-mount-pod.yaml
kubectl get po no-mount -o yaml | grep volumeMounts
kubectl get po no-mount -o yaml | grep volumeMounts -A14

kubectl run default-no-mount --image nginx --dry-run=client -o yaml > default-no-mount-pod.yaml
echo "automountServiceAccountToken: false" >> default-no-mount-pod.yaml
kubectl create -f default-no-mount-pod.yaml
kubectl get po default-no-mount -o yaml | grep serviceAccount
kubectl get po default-no-mount -o yaml | grep serviceAccount -A14
kubectl create role pod-list --verb=list --resource=pods
kubectl create role pod-list-new --verb=list --resource=pods
kubectl create rolebinding pod-list-bind --role=pod-list --serviceaccount=default:nomount-sa

kubectl auth can-i list pods --as system:serviceaccount:default:nomount-sa









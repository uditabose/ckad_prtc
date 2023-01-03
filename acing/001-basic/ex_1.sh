#!/bin/bash

kubectl create -f ch1-nginx.yaml
#----------------
# pod/nginx created


kubectl config view

#----------------
# apiVersion: v1
# clusters:
# - cluster:
#     certificate-authority-data: DATA+OMITTED
#     server: https://kubernetes.docker.internal:6443
#   name: docker-desktop
# contexts:
# - context:
#     cluster: docker-desktop
#     user: docker-desktop
#   name: docker-desktop
# current-context: docker-desktop
# kind: Config
# preferences: {}
# users:
# - name: docker-desktop
#   user:
#     client-certificate-data: REDACTED
#     client-key-data: REDACTED


 kubectl api-resources > acing/ch1-basic/api-resources.txt          
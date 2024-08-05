# Services

One of __central__ concept of Kubernetes.
Provides a discoverable name and IP address.

Similar to deployment, works with Pods via label-based selection.

## Service Types

| Type | What |
|---   |---   |
|ClusterIP | Exposes service on a cluster-internal IP. Reachable from within cluster|
|NodePort| Exposes service on each Node's IP address at a static port. Accessible from outside cluster|
|LoadBalancer|Exposes Service externally using a cloud provider's load balancer|
|ExternalName| Maps a Service to a DNS name|


## Table of Content  <!-- omit in toc -->

- [Services](#services)
  - [Service Types](#service-types)
  - [Creating Service, via Command Line](#creating-service-via-command-line)
    - [Verify the command line Service](#verify-the-command-line-service)
  - [Expose a Pod or Deployment](#expose-a-pod-or-deployment)
    - [Verify the Pod with exposed port](#verify-the-pod-with-exposed-port)
  - [Service via YAML](#service-via-yaml)
    - [Verify the Pod via YAML](#verify-the-pod-via-yaml)
  - [List services](#list-services)
  - [Teardown](#teardown)

## Creating Service, via Command Line

```bash
kubectl create service clusterip nginx-service --tcp=80:9797
service/nginx-service created
```

### Verify the command line Service

```bash
kubectl get service nginx-service
NAME            TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)   AGE
nginx-service   ClusterIP   10.104.18.59   <none>        80/TCP    43s
```

```bash
kubectl describe service nginx-service
Name:              nginx-service
Namespace:         default
Labels:            app=nginx-service
Annotations:       <none>
Selector:          app=nginx-service
Type:              ClusterIP
IP Family Policy:  SingleStack
IP Families:       IPv4
IP:                10.104.18.59
IPs:               10.104.18.59
Port:              80-9797  80/TCP
TargetPort:        9797/TCP
Endpoints:         <none>
Session Affinity:  None
Events:            <none>
```

```bash
kubectl get service nginx-service -o json > stgd/007-services-network/services/clusterip-service-dump.json
NAME            TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)   AGE
nginx-service   ClusterIP   10.104.18.59   <none>        80/TCP    43s
```

## Expose a Pod or Deployment

```bash
kubectl run nginx-clusterip --image=nginx --restart=Never --port=80 --expose
service/nginx-clusterip created
pod/nginx-clusterip created
```

### Verify the Pod with exposed port

```bash
kubectl describe service/nginx-clusterip
Name:              nginx-clusterip
Namespace:         default
Labels:            <none>
Annotations:       <none>
Selector:          run=nginx-clusterip
Type:              ClusterIP
IP Family Policy:  SingleStack
IP Families:       IPv4
IP:                10.105.205.24
IPs:               10.105.205.24
Port:              <unset>  80/TCP
TargetPort:        80/TCP
Endpoints:         10.1.48.81:80
Session Affinity:  None
Events:            <none>
```

```bash
kubectl get pods nginx-clusterip -o json > stgd/007-services-network/services/nginx-clusterip.json
```

## Service via YAML

```bash
kubectl create -f stgd/007-services-network/services/nginx-clusterip-2.yaml
service/ngnix-clusterip-2 created
```

### Verify the Pod via YAML

```bash
kubectl get services ngnix-clusterip-2 -o json > stgd/007-services-network/services/ngnix-clusterip-2.json
```

## List services

```bash
kubectl get services
---
NAME                TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)   AGE
kubernetes          ClusterIP   10.96.0.1       <none>        443/TCP   116d
nginx-clusterip     ClusterIP   10.105.205.24   <none>        80/TCP    32m
nginx-service       ClusterIP   10.104.18.59    <none>        80/TCP    41m
ngnix-clusterip-2   ClusterIP   10.104.228.65   <none>        80/TCP    2m36s
```

## Teardown

```bash
kubectl delete services/nginx-service --force --grace-period=0
kubectl delete services/ngnix-clusterip-2 --force --grace-period=0
```

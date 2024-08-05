# Network Policy

Policy to manage ingress-egress in a cluster

## Table of Content  <!-- omit in toc -->

- [Network Policy](#network-policy)
  - [Create Pod](#create-pod)
  - [Create network Policy](#create-network-policy)
  - [Create the Other Pods](#create-the-other-pods)
    - [Verify](#verify)
  - [Deny all networking](#deny-all-networking)
  - [Teardown](#teardown)

## Create Pod

```bash
kubectl run payment-processor --image=nginx --restart=Never \
-l app=payment-processor,role=api --port 80
pod/payment-processor created
```

```bash
kubectl get pods -o wide
...
payment-processor               1/1     Running                      0                 38s     10.1.52.213   docker-desktop   <none>           <none>
```

## Create network Policy

```bash
kubectl create -f stgd/007-services-network/network/network-policy.yaml
networkpolicy.networking.k8s.io/api-allow created
```

## Create the Other Pods

```bash
kubectl run grocery-store --rm -it --image=busybox \
--restart=Never -l app=grocery-store,role=backend -- /bin/sh
---
If you don't see a command prompt, try pressing enter.
/ # 
/ # 
/ # curl
/bin/sh: curl: not found
/ # wget --spider --timeout=1 10.1.52.213
Connecting to 10.1.52.213 (10.1.52.213:80)
remote file exists
/ # exit
pod "grocery-store" deleted
```

```bash
kubectl run coffeshop --rm -it --image=busybox \
--restart=Never -l app=coffeshop,role=backend -- /bin/sh
---
If you don't see a command prompt, try pressing enter.
/ # 
/ # 
/ # wget --spider --timeout=1 10.1.52.213
Connecting to 10.1.52.213 (10.1.52.213:80)
remote file exists
/ # 
pod "coffeshop" deleted
pod default/coffeshop terminated (Error)
```

### Verify

```bash
kubectl get networkpolicy
---
NAME        POD-SELECTOR                     AGE
api-allow   app=payment-processor,role=api   32m
```

```bash
kubectl describe networkpolicy api-allow
---
Name:         api-allow
Namespace:    default
Created on:   2024-08-05 00:34:26 -0400 EDT
Labels:       <none>
Annotations:  <none>
Spec:
  PodSelector:     app=payment-processor,role=api
  Allowing ingress traffic:
    To Port: <any> (traffic allowed to all ports)
    From:
      PodSelector: app=coffeshop
  Not affecting egress traffic
  Policy Types: Ingress
```

## Deny all networking

```bash
kubectl run backend --image=nginx --restart=Never --port=80
pod/backend created
```

```bash
kubectl get pods backend -o wide
NAME      READY   STATUS    RESTARTS   AGE   IP            NODE             NOMINATED NODE   READINESS GATES
backend   1/1     Running   0          38s   10.1.53.206   docker-desktop   <none>           <none>
```

```bash
kubectl run frontend --rm -it --image=busybox --restart=Never -- /bin/sh
---
/ # 
/ # 
/ # wget --spider --timeout=1 10.1.53.206
Connecting to 10.1.53.206 (10.1.53.206:80)
remote file exists
/ # exit
pod "frontend" deleted
```

---

```bash
kubectl create -f stgd/007-services-network/network/denyall.yaml
networkpolicy.networking.k8s.io/default-deny-all created
```

```bash
kubectl run frontend --rm -it --image=busybox --restart=Never -- /bin/sh                                                                          [1:26:09]

If you don't see a command prompt, try pressing enter.
/ # 
/ # 
/ # wget --spider --timeout=1 10.1.53.206
Connecting to 10.1.53.206 (10.1.53.206:80)
remote file exists
/ # 
pod "frontend" deleted
```


## Teardown

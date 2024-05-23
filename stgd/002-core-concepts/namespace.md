# Namespace

## Table of contents  <!-- omit in toc -->

- [Namespace](#namespace)
  - [See the Namespaces](#see-the-namespaces)
  - [Create a Namespace](#create-a-namespace)
    - [Verify the Namespace](#verify-the-namespace)
  - [Delete the Namespace](#delete-the-namespace)
  - [Do whacko](#do-whacko)
    - [Undo the whacko](#undo-the-whacko)

## See the Namespaces

```bash
kubectl get namespaces > namespaces.txt
```

```bash
NAME                 STATUS   AGE
default              Active   33d
kube-node-lease      Active   33d
kube-public          Active   33d
kube-system          Active   33d
local-path-storage   Active   33d
```

## Create a Namespace

```bash
kubectl create namespace code-red
```

### Verify the Namespace

```bash
kubectl get namespace code-red

---

NAME       STATUS   AGE
code-red   Active   6s
```

## Delete the Namespace

```bash
kubectl delete -f code-red-namespace.yaml --grace-period=0 --force
```

## Do whacko

```bash
kubectl create -f code-red-namespace.yaml
kubectl run pod --image=nginx --restart=Never -n code-red
kubectl get pods -n code-red
...
---
NAME   READY   STATUS    RESTARTS   AGE
pod    1/1     Running   0          57s
```

### Undo the whacko

```bash
kubectl delete namespace code-red
...
kubectl get pods -n code-red
---
No resources found in code-red namespace.
```

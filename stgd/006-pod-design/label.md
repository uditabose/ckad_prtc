# Label

Key-value assigned to Kube object

## Table of Content  <!-- omit in toc -->

- [Label](#label)
  - [Declare label in arguement](#declare-label-in-arguement)
    - [Verify two-labels](#verify-two-labels)
  - [Inspect label](#inspect-label)
  - [Modify Label](#modify-label)
    - [Verify added label](#verify-added-label)
  - [Label selection](#label-selection)
    - [Via Command Line](#via-command-line)
  - [Teardown](#teardown)

## Declare label in arguement

```bash
kubectl run labeled-pod --image=nginx --restart=Never --labels=tier=backend,env=dev
pod/labeled-pod created
```

> OR

```bash
kubectl create -f stgd/006-pod-design/label/two-label-pod.yaml
pod/two-labeled-pod created
```

### Verify two-labels

```bash
kubectl get pod/two-labeled-pod -o yaml > stgd/006-pod-design/label/two-label-pod-description.yaml
```

## Inspect label

```bash
kubectl get pod/two-labeled-pod -o json | jq .metadata.labels
---
{
  "env": "dev",
  "tier": "backend"
}
```

> OR

```bash
kubectl get pods --show-labels
---
NAME                         READY   STATUS                       RESTARTS           AGE     LABELS
configmap-mani-pod           1/1     Running                      7 (14m ago)        89d     name=configmap-mani-pod
configmap-mani-pod-mounted   1/1     Running                      7 (14m ago)        89d     name=configmap-mani-pod-mounted
configmap-pod                1/1     Running                      7 (14m ago)        89d     name=configmap-pod
fs-secured                   1/1     Running                      6 (14m ago)        63d     <none>
incorrect-cmd-pod            0/1     CrashLoopBackOff             3290 (3m54s ago)   32d     <none>
labeled-pod                  1/1     Running                      0                  9m41s   env=dev,tier=backend
nginx                        0/1     Error                        0                  52d     run=nginx
non-root                     0/1     CreateContainerConfigError   0                  63d     <none>
secrets-mounted-pod          1/1     Running                      5 (14m ago)        67d     name=secrets-mounted-pod
secrets-pod                  1/1     Running                      5 (14m ago)        67d     name=secrets-pod
two-labeled-pod              1/1     Running                      0                  6m31s   env=dev,tier=backend
```

## Modify Label

```bash
kubectl label pod labeled-pod region=eu
pod/labeled-pod labeled
```

### Verify added label

```bash
kubectl get pods/labeled-pod --show-labels
NAME          READY   STATUS    RESTARTS   AGE   LABELS
labeled-pod   1/1     Running   0          23m   env=dev,region=eu,tier=backend
```


## Label selection

Query a set of Kubernetes Objects with same label.

### Via Command Line

```bash
kubectl get pods -l env=dev
---
NAME              READY   STATUS    RESTARTS   AGE
labeled-pod       1/1     Running   0          56m
two-labeled-pod   1/1     Running   0          53m
```

> AND

```bash
kubectl get pods -l env=dev -l 'region in (eu)' --show-labels
NAME          READY   STATUS    RESTARTS   AGE   LABELS
labeled-pod   1/1     Running   0          57m   env=dev,region=eu,tier=backend
 
```

## Teardown

```bash
kubectl delete pods/labeled-pod --grace-period=0 --force
pod "labeled-pod" force deleted
```

```bash
kubectl delete pods/two-labeled-pod --grace-period=0 --force
pod "two-labeled-pod" force deleted
```

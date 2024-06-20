# Liveness

Liveness probe of a Pod

## Table of Content  <!-- omit in toc -->

- [Liveness](#liveness)
  - [Create the liveness Pod](#create-the-liveness-pod)
    - [Verify liveness Pod](#verify-liveness-pod)
  - [Teardown](#teardown)

## Create the liveness Pod

```bash
kubectl create -f stgd/005-observability/liveness/liveness-probe-pod.yaml
pod/liveness-pod created
```

### Verify liveness Pod

```bash
kubectl get pod liveness-pod
NAME           READY   STATUS    RESTARTS      AGE
liveness-pod   1/1     Running   1 (95s ago)   3m36s
```

```bash
kubectl describe pod liveness-pod > stgd/005-observability/liveness/liveness-probe-pod-dump.txt
```

## Teardown

```bash
kubectl delete pods/liveness-pod --force --grace-period=0
Warning: Immediate deletion does not wait for confirmation that the running resource has been terminated. The resource may continue to run on the cluster indefinitely.
pod "liveness-pod" force deleted
```

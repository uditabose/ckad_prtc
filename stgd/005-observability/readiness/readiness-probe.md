# Readiness Probe


## Table of Content  <!-- omit in toc -->

- [Readiness Probe](#readiness-probe)
  - [Create Pod with readiness probe](#create-pod-with-readiness-probe)
    - [Verify](#verify)
  - [Teardown](#teardown)


## Create Pod with readiness probe

```bash
kubectl create -f stgd/005-observability/readiness/readiness-probe-pod.yaml
pod/readiness-pod created
```

### Verify

```bash
kubectl get pods readiness-pod -o json > stgd/005-observability/readiness/readiness-probe-pod-dump.json

kubectl describe pods readiness-pod > stgd/005-observability/readiness/readiness-probe-pod-desc.txt
```

## Teardown

```bash
kubectl delete readiness-pod --force --grace-period=0
```

# Startup Probe

Purpose is t figure out when the application fully started.

Two conditions -

1. application is started
2. application doesn't respond within timeout period

## Table of Content  <!-- omit in toc -->

- [Startup Probe](#startup-probe)
  - [Pod with Startup probe](#pod-with-startup-probe)
  - [Verify](#verify)
  - [Teardown](#teardown)

## Pod with Startup probe

```bash
kubectl create -f stgd/005-observability/startup/startup-probe-pod.yaml
pod/startup-pod created
```

## Verify

```bash
kubectl get pod startup-pod
startup-pod   1/1     Running   0          42s
```

```bash
kubectl get pod startup-pod -o json > stgd/005-observability/startup/startup-probe-pod.json

kubectl describe pods/startup-pod > stgd/005-observability/startup/startup-probe-pod-dump.txt
```

## Teardown

```bash
kubectl delete pods/startup-pod --force --grace-period=0
Warning: Immediate deletion does not wait for confirmation that the running resource has been terminated. The resource may continue to run on the cluster indefinitely.
pod "startup-pod" force deleted
```

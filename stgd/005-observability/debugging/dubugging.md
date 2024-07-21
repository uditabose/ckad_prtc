# Debugging kubernetes

Debug via

- `describe`
- logs
- interactive shell

## Table of Content  <!-- omit in toc -->

- [Debugging kubernetes](#debugging-kubernetes)
  - [Events](#events)
  - [Get logs](#get-logs)
  - [Teardown](#teardown)

## Events

```bash
kubectl get events
LAST SEEN   TYPE     REASON   OBJECT         MESSAGE
105s        Normal   Pulled   pod/non-root   Container image "nginx:1.18.0" already present on machine
```

## Get logs

```bash
kubectl create -f stgd/005-observability/debugging/incorrect-pod.yaml
pod/incorrect-cmd-pod created
```

```bash
kubectl get  pod/incorrect-cmd-pod
NAME                READY   STATUS             RESTARTS      AGE
incorrect-cmd-pod   0/1     CrashLoopBackOff   7 (19s ago)   11m
```

```bash
kubectl describe pod/incorrect-cmd-pod > stgd/005-observability/debugging/incorrect-pod-dump.txt   
```

```bash
kubectl get events > stgd/005-observability/debugging/incorrect-pod-events.txt   
```

```bash
kubectl logs pod/incorrect-cmd-pod
/bin/sh: unknown: not found
```



## Teardown

```bash
kubectl delete pods/incorrect-cmd-pod
```

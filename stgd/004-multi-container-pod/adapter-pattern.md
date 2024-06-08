# Adapter Pattern

Transforms output of main container

## Table of Content  <!-- omit in toc -->

- [Adapter Pattern](#adapter-pattern)
  - [Create a Pod with a log transformer](#create-a-pod-with-a-log-transformer)
    - [Verify](#verify)
  - [Teardown](#teardown)

## Create a Pod with a log transformer

```bash
kubectl create -f stgd/004-multi-container-pod/apadter-pattern/adapter-pattern-pod.yaml
pod/adapter created
```

### Verify

```bash
kubectl get pods adapter -o json > stgd/004-multi-container-pod/apadter-pattern/adapter-pattern-pod-dump.json
```

```bash
kubectl logs adapter -c transformer
/bin/sh: can't open  /var/logs/diskspace.txt: no such file
/bin/sh: can't open  /var/logs/diskspace.txt: no such file
/bin/sh: can't open  /var/logs/diskspace.txt: no such file
/bin/sh: can't open  /var/logs/diskspace.txt: no such file
/bin/sh: can't open  /var/logs/diskspace.txt: no such file
/bin/sh: can't open  /var/logs/diskspace.txt: no such file
```


```bash
kubectl exec  adapter -it  -c app -- /bin/sh
---
Fri Jun  7 16:36:20 UTC 2024 | 8.0K     /root
Fri Jun  7 16:36:20 UTC 2024 | 8.0K     /root
Fri Jun  7 16:36:20 UTC 2024 | 8.0K     /root
Fri Jun  7 16:36:20 UTC 2024 | 8.0K     /root
Fri Jun  7 16:36:20 UTC 2024 | 8.0K     /root
Fri Jun  7 16:36:20 UTC 2024 | 8.0K     /root
Fri Jun  7 16:36:20 UTC 2024 | 8.0K     /root
Fri Jun  7 16:36:20 UTC 2024 | 8.0K     /root
Fri Jun  7 16:36:20 UTC 2024 | 8.0K     /root
Fri Jun  7 16:36:20 UTC 2024 | 8.0K     /root
Fri Jun  7 16:36:20 UTC 2024 | 8.0K     /root
```

## Teardown

```bash
kubectl delete pods/adapter --force --grace-period=0
---
Warning: Immediate deletion does not wait for confirmation that the running resource has been terminated. The resource may continue to run on the cluster indefinitely.
pod "adapter" force deleted
```

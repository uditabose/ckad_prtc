# Init Containers

All stuff about Init containers

## Table of Content  <!-- omit in toc -->

- [Init Containers](#init-containers)
  - [Create Pod with 1 Init Container](#create-pod-with-1-init-container)
    - [Verify the init Pod](#verify-the-init-pod)
  - [Teardown](#teardown)

## Create Pod with 1 Init Container

```bash
kubectl create -f stgd/004-multi-container-pod/init-container/init-container-pod.yaml
pod/business-app created
```

### Verify the init Pod

```bash
kubectl get pod business-app
---
NAME           READY   STATUS    RESTARTS   AGE
business-app   1/1     Running   0          42s

---
kubectl describe pod business-app > stgd/004-multi-container-pod/init-container/init-container-pod-dump.txt

---

kubectl logs business-app -c configurer
Configuring application...

kubectl logs business-app -c web
```

## Teardown

```bash
kubectl delete pods/business-app --force --grace-period=0
---
Warning: Immediate deletion does not wait for confirmation that the running resource has been terminated. The resource may continue to run on the cluster indefinitely.
pod "business-app" force deleted
```

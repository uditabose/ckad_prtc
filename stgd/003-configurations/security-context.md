

# Security Context

Reduce attack vector

- use a non-root user
- set access to user and group
- granting some access to a process but not all of the root-user

## Table of content  <!-- omit in toc -->

- [Security Context](#security-context)
  - [Create non-root Pod](#create-non-root-pod)
  - [Create Pod with filesystem group](#create-pod-with-filesystem-group)

## Create non-root Pod

```bash
kubectl create -f stgd/003-configurations/security-context/security-context-secured-container-error-pod.yaml
pod/non-root created
```

---

```bash
kubectl describe pods/non-root > stgd/003-configurations/security-context/non-root-pod.txt
```

## Create Pod with filesystem group

```bash
kubectl create -f stgd/003-configurations/security-context/security-context-pod-security-pod.yaml
pod/fs-secured created
```

---

```bash
kubectl describe pods/fs-secured > stgd/003-configurations/security-context/fs-secured-pod.txt
```

```bash
kubectl exec -it fs-secured -- /bin/bash
root@fs-secured:/# ls -l /data/
total 4
drwxrwsrwx 2 root 3500 4096 May 23 02:34 app
root@fs-secured:/# ls -l /data/app
total 0
root@fs-secured:/# touch /data/app/logs.txt
root@fs-secured:/# ls -l /data/app
total 0
-rw-r--r-- 1 root 3500 0 May 23 02:37 logs.txt
root@fs-secured:/# 
```


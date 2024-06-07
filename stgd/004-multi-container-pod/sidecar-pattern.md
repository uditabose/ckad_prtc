# Sidecar Pattern

Usually handles helper functionality. Usually asyc, and not involved in public API.

- logging
- synchronization
- watcher capabilities

## Table of Content  <!-- omit in toc -->

- [Sidecar Pattern](#sidecar-pattern)
  - [Sidecar which reads log file](#sidecar-which-reads-log-file)
    - [Verify the Pod](#verify-the-pod)
  - [Teardown](#teardown)

## Sidecar which reads log file

```bash
kubectl create -f stgd/004-multi-container-pod/sidecar-pattern/sidecar-pattern-pod.yaml
pod/webserver created
```

### Verify the Pod

```bash
kubectl describe pod/webserver > stgd/004-multi-container-pod/sidecar-pattern/sidecar-pattern-pod-dump.txt

kubectl get pods webserver -o json > stgd/004-multi-container-pod/sidecar-pattern/sidecar-pattern-webserver.json

kubectl get pods webserver -o json > stgd/004-multi-container-pod/sidecar-pattern/sidecar-pattern-webserver.json

```

---

```bash
kubectl logs webserver -c nginx
/docker-entrypoint.sh: /docker-entrypoint.d/ is not empty, will attempt to perform configuration
/docker-entrypoint.sh: Looking for shell scripts in /docker-entrypoint.d/
/docker-entrypoint.sh: Launching /docker-entrypoint.d/10-listen-on-ipv6-by-default.sh
10-listen-on-ipv6-by-default.sh: Getting the checksum of /etc/nginx/conf.d/default.conf
10-listen-on-ipv6-by-default.sh: Enabled listen on IPv6 in /etc/nginx/conf.d/default.conf
/docker-entrypoint.sh: Launching /docker-entrypoint.d/20-envsubst-on-templates.sh
/docker-entrypoint.sh: Configuration complete; ready for start up
```

---

```bash
kubectl exec -it webserver -- /bin/bash
---
root@webserver:/# ls -l /var/log/nginx/
total 0
-rw-r--r-- 1 root root 0 Jun  7 03:09 access.log
-rw-r--r-- 1 root root 0 Jun  7 03:09 error.log
root@webserver:/# cat  /var/log/nginx/access.log 
root@webserver:/# exit
exit
```

## Teardown

```bash
kubectl delete pods/webserver --force --grace-period=0
---
Warning: Immediate deletion does not wait for confirmation that the running resource has been terminated. The resource may continue to run on the cluster indefinitely.
pod "webserver" force deleted
```

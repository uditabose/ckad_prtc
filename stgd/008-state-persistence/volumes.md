# Volumes

| Type  | Description     |
|---    |---              |
|emptyDir  |Empty dir. Persisted for the lifespan of the Pod. cache, data exchange between containers of the Pod |
|hostPath  |Path from host node's file system |
|configMap, secret  |Injct configuration data |
|nfs  |NFS, persisted beyond Pod life  |
|persistentVolumeClaim  |Claims a Persistent Volume  |

## Table of Content  <!-- omit in toc -->

- [Volumes](#volumes)
  - [Pod with Volume](#pod-with-volume)
    - [Verify the volume Pod](#verify-the-volume-pod)
  - [Teardown](#teardown)

## Pod with Volume

```bash
kubectl create -f stgd/008-state-persistence/volumes/pod-volume.yaml
pod/volume-pod created
```

### Verify the volume Pod

```bash
kubectl get pod volume-pod
NAME         READY   STATUS    RESTARTS   AGE
volume-pod   1/1     Running   0          74s
```

```bash
kubectl exec volume-pod -it -- /bin/sh
# ls
bin  boot  dev  docker-entrypoint.d  docker-entrypoint.sh  etc  home  lib  media  mnt  opt  proc  root  run  sbin  srv  sys  tmp  usr  var
# ls -l /var/lo
ls: cannot access '/var/lo': No such file or directory
# ls -l /var/logs
total 0
# touch /var/logs/app-logs.log
# ls -l /var/logs
total 0
-rw-r--r-- 1 root root 0 Aug  8 01:44 app-logs.log
```

## Teardown

```bash
kubectl delete pod/volume-pod --force --grace-period=0
```

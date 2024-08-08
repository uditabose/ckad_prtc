# Persistent Volume

- Persistent Volume is a storage device in a Kube cluster
- completely decoupled from Pod
- lives beyond Pod, and even cluster
- PersistentVolumeClaim is how Kube requests PersistentVolume resource
- Only via manifest

## Table of Content  <!-- omit in toc -->

- [Persistent Volume](#persistent-volume)
  - [Create Persistent Volume](#create-persistent-volume)
    - [Verify the Volume](#verify-the-volume)
  - [Create PersistVolumeClaim](#create-persistvolumeclaim)
  - [verify PersistVolumeClaim](#verify-persistvolumeclaim)
  - [Mounting PersistVolumeClaim in a Pod](#mounting-persistvolumeclaim-in-a-pod)
    - [Verify the Pod with persistent volume](#verify-the-pod-with-persistent-volume)
  - [Teardown](#teardown)

## Create Persistent Volume

```bash
kubectl create -f stgd/008-state-persistence/volumes/persistent-volume.yaml
persistentvolume/db-pv created
```

### Verify the Volume

```bash
kubectl get pv db-pv
NAME    CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS      CLAIM   STORAGECLASS   VOLUMEATTRIBUTESCLASS   REASON   AGE
db-pv   500Mi      RWO            Retain           Available                          <unset>                          75s
```

## Create PersistVolumeClaim

```bash
kubectl create -f stgd/008-state-persistence/volumes/persistent-volume-claim.yaml
persistentvolumeclaim/mypvc created
```

## verify PersistVolumeClaim

```bash
kubectl get pvc mypvc
NAME    STATUS   VOLUME                                     CAPACITY   ACCESS MODES   STORAGECLASS   VOLUMEATTRIBUTESCLASS   AGE
mypvc   Bound    pvc-1d1b6582-5af7-4189-92f0-1cb626d6ff97   256Mi      RWO            hostpath       <unset>                 98s
```

## Mounting PersistVolumeClaim in a Pod

```bash
kubectl create -f stgd/008-state-persistence/volumes/pod-consuming-pvc.yaml
pod/app-consuming-pvc created
```

### Verify the Pod with persistent volume

```bash
kubectl get pod/app-consuming-pvc
NAME                READY   STATUS    RESTARTS   AGE
app-consuming-pvc   1/1     Running   0          55s
```

```bash
kubectl describe pod/app-consuming-pvc > stgd/008-state-persistence/volumes/app-consuming-pvc.txt
```

```bash
kubectl exec app-consuming-pvc -it -- /bin/sh
/ # ls -l /mnt/data
total 0
/ # touch  /mnt/data/app.db
/ # ls -l /mnt/data
total 0
-rw-r--r--    1 root     root             0 Aug  8 03:57 app.db
/ # 
```


## Teardown

```bash
kubectl delete persistentvolume/db-pv --force --grace-period=0
Warning: Immediate deletion does not wait for confirmation that the running resource has been terminated. The resource may continue to run on the cluster indefinitely.
persistentvolume "db-pv" force deleted
---

kubectl delete persistentvolumeclaim/mypvc --force --grace-period=0
Warning: Immediate deletion does not wait for confirmation that the running resource has been terminated. The resource may continue to run on the cluster indefinitely.
---

kubectl delete pod/app-consuming-pvc --force --grace-period=0

Warning: Immediate deletion does not wait for confirmation that the running resource has been terminated. The resource may continue to run on the cluster indefinitely.
pod "app-consuming-pvc" force deleted
```

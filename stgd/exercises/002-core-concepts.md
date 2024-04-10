
# Exercises on Core Concepts

## Table of content

- [Exercises on Core Concepts](#exercises-on-core-concepts)
  - [Table of content](#table-of-content)
  - [1. Create a new Pod](#1-create-a-new-pod)
  - [2. Get the details of the Pod](#2-get-the-details-of-the-pod)
  - [3. Create temporary Pod](#3-create-temporary-pod)
  - [4. Get logs](#4-get-logs)
  - [5. Add Environment variables](#5-add-environment-variables)
  - [6. Open shell](#6-open-shell)
  - [7. Create YAML for Pod named Pool](#7-create-yaml-for-pod-named-pool)
  - [8. Edit the Pod named Pool](#8-edit-the-pod-named-pool)
  - [9. Inspect the events](#9-inspect-the-events)
  - [10. Delete the namespace](#10-delete-the-namespace)

## 1. Create a new Pod

Create a new Pod named `nginx` running the image `nginx:1.17.10`. Expose container port 80. The pod live in the namespace `ckad`.

```bash
kubectl create -f "002-01-namespace.yaml"
# namespace/ckad created

kubectl create -f "002-01-pod.yaml" --namespace=ckad
#pod/nginx-002 created
```

## 2. Get the details of the Pod

Get the details of the Pod including its IP address

```bash
kubectl get pods -n ckad -o wide
# NAME        READY   STATUS    RESTARTS   AGE   IP           NODE                 NOMINATED NODE   READINESS GATES
# nginx-002   1/1     Running   0          46s   10.244.2.2   acing-multi-worker   <none>           <none>

kubectl get pods -n ckad -o json

kubectl get pods -n ckad -o json | jq '.items[0].status.hostIP'
# "172.18.0.8"
```


## 3. Create temporary Pod

Create a temporary Pod that uses `busybox` image to execute a `wget` command inside of the container. The `wget` command should access the endpoint exposed by the nginx conytainer. You should see the HTML response body rendered in the terminal.

```bash
kubectl run busybox --image=busybox --restart=Never --rm -it -n ckad -- wget -O- 10.244.2.2:80
# Connecting to 10.244.2.2:80 (10.244.2.2:80)
# writing to stdout
# <!DOCTYPE html>
# <html>
# <head>
# <title>Welcome to nginx!</title>
# <style>
#     body {
#         width: 35em;
#         margin: 0 auto;
#         font-family: Tahoma, Verdana, Arial, sans-serif;
#     }
# </style>
# </head>
# <body>
# <h1>Welcome to nginx!</h1>
# <p>If you see this page, the nginx web server is successfully installed and
# working. Further configuration is required.</p>

# <p>For online documentation and support please refer to
# <a href="http://nginx.org/">nginx.org</a>.<br/>
# Commercial support is available at
# <a href="http://nginx.com/">nginx.com</a>.</p>

# <p><em>Thank you for using nginx.</em></p>
# </body>
# </html>
# -                    100% |********************************|   612  0:00:00 ETA
# written to stdout
# pod "busybox" deleted
```


## 4. Get logs

Get the logs of the `nginx` container.

```bash
kubectl logs nginx-002 -n ckad
# 10.244.2.3 - - [07/Apr/2024:04:12:03 +0000] "GET / HTTP/1.1" 200 612 "-" "Wget" "-"
```


## 5. Add Environment variables

Add environment variables `DB_URL=postgresql://mydb:5432` and `DB_USER=admin` to the container of the `nginx` Pod.

```bash
kubectl delete pod nginx-002 --namespace=ckad
# pod "nginx-002" deleted

kubectl create -f "002-01-pod.yaml" --namespace=ckad
# pod/nginx-002 created
```

## 6. Open shell

Open a shell for the nginx container and inspect the contents of the current directory `ls -l`.

```bash
kubectl -n ckad  exec  -it nginx-002 -- /bin/bash
# root@nginx-002:/# 

root@nginx-002:/# ls -l

# total 64
# drwxr-xr-x   1 root root 4096 May 15  2020 bin
# drwxr-xr-x   2 root root 4096 May  2  2020 boot
# drwxr-xr-x   5 root root  360 Apr 10 14:52 dev
# drwxr-xr-x   1 root root 4096 Apr 10 14:52 etc
# drwxr-xr-x   2 root root 4096 May  2  2020 home
# drwxr-xr-x   1 root root 4096 May 15  2020 lib
# drwxr-xr-x   2 root root 4096 May 14  2020 media
# drwxr-xr-x   2 root root 4096 May 14  2020 mnt
# drwxr-xr-x   2 root root 4096 May 14  2020 opt
# dr-xr-xr-x 267 root root    0 Apr 10 14:52 proc
# drwx------   2 root root 4096 May 14  2020 root
# drwxr-xr-x   1 root root 4096 Apr 10 14:52 run
# drwxr-xr-x   2 root root 4096 May 14  2020 sbin
# drwxr-xr-x   2 root root 4096 May 14  2020 srv
# dr-xr-xr-x  11 root root    0 Apr 10 14:52 sys
# drwxrwxrwt   1 root root 4096 May 15  2020 tmp
# drwxr-xr-x   1 root root 4096 May 14  2020 usr
# drwxr-xr-x   1 root root 4096 May 14  2020 var
# root@nginx-002:/# 
```


## 7. Create YAML for Pod named Pool


Create YAML manifest for a Pod named `loop` that runs the `busybox` image in a container. The container should run the following command 

```bash
for i in {1..10}; do echo "Welcome $i times"
```

```bash
kubectl run loop --image=busybox:latest -o yaml --dry-run=client \
 --restart=Never -- /bin/sh -c 'for i in 1 2 3 4 5 6 7 8 9 10; \
 do echo "Welcome $i times"; done' \
 > 002-07-pod.yaml
```

---

```bash
kubectl create -f 002-07-pod.yaml --namespace=ckad

kubectl get pods loop --namespace=ckad
# NAME   READY   STATUS               RESTARTS   AGE
# loop   0/1     ContainerCannotRun   0          4s
```

## 8. Edit the Pod named Pool

Edit the Pod named `loop`. Change the command run in an endless loop.Each iteration should `echo` the current date

```bash
# clean up first
kubectl delete pods loop --namespace=ckad --grace-period=0 --force

kubectl run loop --image=busybox:latest --restart=Never \
 --dry-run=client -o yaml -- /bin/sh -c \
 'while [ 1 -eq 1 ]; do date; done' \
> 002-08-pod.yaml
```

---

```bash
kubectl create -f 002-08-pod.yaml --namespace=ckad

kubectl logs  loop -n ckad
# Wed Apr 10 20:52:31 UTC 2024
# Wed Apr 10 20:52:41 UTC 2024
# Wed Apr 10 20:52:51 UTC 2024
# Wed Apr 10 20:53:01 UTC 2024
# Wed Apr 10 20:53:11 UTC 2024
# Wed Apr 10 20:53:21 UTC 2024
# Wed Apr 10 20:53:31 UTC 2024
# Wed Apr 10 20:53:41 UTC 2024
# Wed Apr 10 20:53:51 UTC 2024
# Wed Apr 10 20:54:01 UTC 2024
# Wed Apr 10 20:54:11 UTC 2024
```

## 9. Inspect the events

Inspect the events and the status of the Pod `loop`.

```bash
kubectl describe pods/loop --namespace=ckad | tee 002-08-pod-describe.txt
```

## 10. Delete the namespace

Delete the namespace `ckad` and its Pods.

```bash
kubectl delete namespace ckad --force --grace-period=0
```

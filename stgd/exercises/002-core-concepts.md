
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


## 7. Create YAML for Pod named Pool


## 8. Edit the Pod named Pool


## 9. Inspect the events

## 10. Delete the namespace

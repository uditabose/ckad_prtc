# Services, NodePort

Node's IP can be accessed via a port in the range 30000 and 32767

## Table of Content  <!-- omit in toc -->

- [Services, NodePort](#services-nodeport)
  - [Patch the previous service](#patch-the-previous-service)
    - [Verify the service port](#verify-the-service-port)
  - [Teardown](#teardown)

## Patch the previous service

```bash
kubectl patch services/nginx-service -p '{ "spec": {"type": "NodePort"} }'
service/nginx-service patched
```

### Verify the service port

```bash
kubectl get service nginx-service
NAME            TYPE       CLUSTER-IP     EXTERNAL-IP   PORT(S)        AGE
nginx-service   NodePort   10.104.18.59   <none>        80:30384/TCP   123m
```

```bash
kubectl get nodes
NAME             STATUS   ROLES           AGE    VERSION
docker-desktop   Ready    control-plane   116d   v1.29.1
```

```bash
kubectl describe node docker-desktop | grep InternalIP:
  InternalIP:  192.168.65.3
```

## Teardown

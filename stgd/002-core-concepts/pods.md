
# Container, Pod creation, Namespace

## Table of Contents

- [Container, Pod creation, Namespace](#container-pod-creation-namespace)
  - [Table of Contents](#table-of-contents)
  - [Create Hazelcast Pod](#create-hazelcast-pod)
    - [Verify Pod](#verify-pod)
  - [View Pod Logs](#view-pod-logs)
  - [In the Pod](#in-the-pod)
  - [Delete the Pod](#delete-the-pod)


## Create Hazelcast Pod

```bash
kubectl create -f hazelcast-pod.yaml
```

### Verify Pod

```bash
kubectl describe pods 
kubectl describe pods hazelcast

kubectl get pods hazelcast -o json > hazelcast-pod.json
```

## View Pod Logs

```bash
kubectl logs hazelcast

kubectl logs hazelcast > hazelcast-pod.log
```

## In the Pod

```bash
kubectl exec -it hazelcast -- /bin/bash

---
hazelcast:/opt/hazelcast$ ls -l
total 24
-rw-rw-r--    1 root     root           319 Nov  9 13:13 LICENSE
-rw-r--r--    1 root     root          3878 Nov  9 13:27 NOTICE
drwxrwxr-x    3 root     root          4096 Nov  9 13:13 bin
drwxr-xr-x    1 root     root          4096 Mar 19 06:07 config
drwxrwxr-x    2 root     root          4096 Nov  9 13:13 lib
drwxr-xr-x    2 root     root          4096 Nov  9 13:32 licenses
```

> just the env

```bash
kubectl exec hazelcast -- env

---
PATH=/opt/hazelcast/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
HOSTNAME=hazelcast
HZ_HOME=/opt/hazelcast
CLASSPATH_DEFAULT=/opt/hazelcast/*
JAVA_OPTS_DEFAULT=-Djava.net.preferIPv4Stack=true -XX:MaxRAMPercentage=80.0 -XX:MaxGCPauseMillis=5
PROMETHEUS_PORT=
PROMETHEUS_CONFIG=/opt/hazelcast/config/jmx_agent_config.yaml
CLASSPATH=
JAVA_OPTS=
HAZELCAST_CONFIG=config/hazelcast-docker.xml
LANG=C.UTF-8
DNS_DOMAIN=cluster
KUBERNETES_PORT_443_TCP_ADDR=10.96.0.1
KUBERNETES_SERVICE_HOST=10.96.0.1
KUBERNETES_SERVICE_PORT=443
KUBERNETES_SERVICE_PORT_HTTPS=443
KUBERNETES_PORT=tcp://10.96.0.1:443
KUBERNETES_PORT_443_TCP=tcp://10.96.0.1:443
KUBERNETES_PORT_443_TCP_PROTO=tcp
KUBERNETES_PORT_443_TCP_PORT=443
HOME=/home/hazelcast
```

## Delete the Pod

```bash
kubectl delete pod hazelcast
kubectl delete -f hazelcast-pod.yaml
```

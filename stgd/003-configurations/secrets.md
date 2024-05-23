# Creating Secret

## Table of content  <!-- omit in toc -->

- [Creating Secret](#creating-secret)
  - [Types](#types)
  - [From where](#from-where)
    - [Literal valus](#literal-valus)
    - [From env file](#from-env-file)
    - [From a file](#from-a-file)
    - [From declarative declaration](#from-declarative-declaration)
  - [Mounting a Sectret as volume](#mounting-a-sectret-as-volume)

## Types

- **generic**: creates secret from file, directory or literal
- **docker-registry**: creates secret to use with a Docker registry
- **tls**: creates TLS secret

## From where

same as [From where](#from-where)

### Literal valus

```bash
kubectl create secret generic literal-creds --from-literal=pwd=s3cre!
secret/literal-creds created
```

---

```bash
kubectl describe secret/literal-creds 
...

Name:         literal-creds
Namespace:    default
Labels:       <none>
Annotations:  <none>

Type:  Opaque

Data
====
pwd:  6 bytes
```

### From env file

```bash
kubectl create secret generic env-creds --from-env-file=secrets.env
secret/env-creds created
```

---

```bash
kubectl describe secret/env-creds
...

Name:         env-creds
Namespace:    default
Labels:       <none>
Annotations:  <none>

Type:  Opaque

Data
====
password:  9 bytes
```

### From a file

```bash
kubectl create secret generic file-creds --from-file=id_rsa='/Users/uditabose/.ssh/id_rsa'
secret/file-creds created
```

---

```bash
kubectl describe secret/file-creds
...

Name:         file-creds
Namespace:    default
Labels:       <none>
Annotations:  <none>

Type:  Opaque

Data
====
id_rsa:  3434 bytes
```

### From declarative declaration

```bash
echo -n 'pa88W0rd!' | base64
...
cGE4OFcwcmQh
```

```bash
kubectl create -f stgd/003-configurations/secrets.yaml
...
secret/declarative-secret created

kubectl create -f stgd/003-configurations/secrets_pod.yaml
...
pod/secrets-pod created
```

---

```bash
kubectl describe pods/secrets-pod > stgd/003-configurations/secrets/secrets-pod-dump.txt
---

kubectl exec secrets-pod -- env
...
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
HOSTNAME=secrets-pod
password=pa88W0rd!
KUBERNETES_SERVICE_HOST=10.96.0.1
KUBERNETES_SERVICE_PORT=443
KUBERNETES_SERVICE_PORT_HTTPS=443
KUBERNETES_PORT=tcp://10.96.0.1:443
KUBERNETES_PORT_443_TCP=tcp://10.96.0.1:443
KUBERNETES_PORT_443_TCP_PROTO=tcp
KUBERNETES_PORT_443_TCP_PORT=443
KUBERNETES_PORT_443_TCP_ADDR=10.96.0.1
NGINX_VERSION=1.19.0
NJS_VERSION=0.4.1
PKG_RELEASE=1~buster
HOME=/root
```

## Mounting a Sectret as volume

```bash
kubectl create -f stgd/003-configurations/secrets-pod-mounted.yaml
...
pod/secrets-mounted-pod created
```

---

```bash
kubectl describe pods/secrets-mounted-pod > stgd/003-configurations/secrets/secrets-mounted-pod-dump.txt
```

```bash
kubectl exec -it secrets-mounted-pod -- /bin/bash
---
root@secrets-mounted-pod:/# ls -l /var/app
total 0
lrwxrwxrwx 1 root root 13 May 19 21:20 id_rsa -> ..data/id_rsa
root@secrets-mounted-pod:/# 

---

root@secrets-mounted-pod:/# cat  /var/app/id_rsa
-----BEGIN OPENSSH PRIVATE KEY-----
b3BlbnNzaC1rZXktdjEAAAAACmFlczI1Ni1jdHIAAAAGYmNyeXB0AAAAGAAAABDlbXmMUH
...
...
MCIhNge8psrlijCPXH+e0KwQ+lQjPe8KOF2Pk55RLqA9kNItfvY4ghJXhmc1ttUZDSztDd
pX04CDzp9qwopkxkcljAT2yvI=
-----END OPENSSH PRIVATE KEY-----
```

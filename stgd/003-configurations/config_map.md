
# Creating ConfigMap

Describes details of config map

## Table of content

- [Creating ConfigMap](#creating-configmap)
  - [Table of content](#table-of-content)
  - [From where](#from-where)
    - [Literal values](#literal-values)
    - [Single file with key-value, env file](#single-file-with-key-value-env-file)
    - [Single text file](#single-text-file)
    - [From a directory](#from-a-directory)
    - [From yaml](#from-yaml)
  - [Consume ConfigMap as Environment variable](#consume-configmap-as-environment-variable)
    - [Manipulated config names](#manipulated-config-names)
    - [Mount ConfigMap as Volume](#mount-configmap-as-volume)


## From where

- Literal value, key-value pair
- file with key-value pair
- file with arbitrary content
- directory with one or many file

### Literal values

```bash
kubectl create configmap literal-config --from-literal=db=staging
configmap/literal-config created
```

---

```bash
kubectl describe configmap  literal-config
Name:         literal-config
Namespace:    default
Labels:       <none>
Annotations:  <none>

Data
====
db:
----
staging

BinaryData
====

Events:  <none>
```

### Single file with key-value, env file

```bash
kubectl create configmap env-config --from-env-file=db_config.env
configmap/env-config created
```

---

```bash
kubectl describe configmap env-config
Name:         env-config
Namespace:    default
Labels:       <none>
Annotations:  <none>

Data
====
NIADA_DB_USER:
----
"postgres"
STRIPE_API_KEY:
----
"sk_test_51OCmaUDyzTAoRf9Pt0WrD7ZlNaXpGkTtKRGmkqi30JF1N2Q8O8CycGjcEwskWcbxlSAlYOGdpQBoZnBlL53BRiuh007D3jCr2O"
STRIPE_LAST_ID_FILE:
----
"stripe_last_id"
NIADA_DB_DRIVER:
----
"postgresql"
NIADA_DB_NAME:
----
"niada-seeder"
NIADA_DB_PASSWORD:
----
""
NIADA_DB_PORT:
----
"5432"
NIADA_DB_URL:
----
"localhost"

BinaryData
====

Events:  <none>
```

### Single text file

```bash
kubectl create configmap file-config --from-file=db_config.txt
configmap/file-config created
```

---

```bash
kubectl describe configmap file-config
Name:         file-config
Namespace:    default
Labels:       <none>
Annotations:  <none>

Data
====
db_config.txt:
----
db_stuff, more_stuff
other_stuff, the_that_stuff


BinaryData
====

Events:  <none>
```

### From a directory

```bash
kubectl create configmap dir-config --from-file=configs
configmap/dir-config created
```

---

```bash
kubectl describe configmap dir-config
Name:         dir-config
Namespace:    default
Labels:       <none>
Annotations:  <none>

Data
====
config.env:
----
# database config
DB_DRIVER="postgresql"
DB_URL="localhost"
DB_USER="postgres"
DB_PASSWORD=""
DB_PORT="5432"
DB_NAME="niada-seeder"

# stripe config
STRIPE_API_KEY="sk_test_51OCmaUDyzTAoRf9Pt0WrD7ZlNaXpGkTtKRGmkqi30JF1N2Q8O8CycGjcEwskWcbxlSAlYOGdpQBoZnBlL53BRiuh007D3jCr2O"
STRIPE_LAST_ID_FILE="stripe_last_id"

config.txt:
----
db_stuff_1, more_stuff_1
other_stuff_1, the_that_stuff_1


BinaryData
====

Events:  <none>
```

### From yaml

```bash
kubectl create -f config.yaml
configmap/yaml-config created
```

---

```bash
kubectl describe configmap yaml-config
Name:         yaml-config
Namespace:    default
Labels:       <none>
Annotations:  <none>

Data
====
lala:
----
palooza

BinaryData
====

Events:  <none>

```

## Consume ConfigMap as Environment variable

```bash
kubectl create -f configmap_pod.yaml
pod/configmap-pod created
```

---

```bash
kubectl get pods configmap-pod -o yaml 2>&1 | tee configmap-pod-dump.yaml
```

```bash
kubectl exec configmap-pod -- env
----

PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
HOSTNAME=configmap-pod
lala=palooza
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

### Manipulated config names

```bash
kubectl create -f configmap-mani-pod.yaml
pod/configmap-mani-pod created
```

---

```bash
kubectl exec configmap-mani-pod -- env
----

PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
HOSTNAME=configmap-mani-pod
DB_URL="localhost"
DB_USER="postgres"
KUBERNETES_SERVICE_PORT_HTTPS=443
KUBERNETES_PORT=tcp://10.96.0.1:443
KUBERNETES_PORT_443_TCP=tcp://10.96.0.1:443
KUBERNETES_PORT_443_TCP_PROTO=tcp
KUBERNETES_PORT_443_TCP_PORT=443
KUBERNETES_PORT_443_TCP_ADDR=10.96.0.1
KUBERNETES_SERVICE_HOST=10.96.0.1
KUBERNETES_SERVICE_PORT=443
NGINX_VERSION=1.19.0
NJS_VERSION=0.4.1
PKG_RELEASE=1~buster
HOME=/root
```

### Mount ConfigMap as Volume

```bash
kubectl create -f configmap-mani-pod-mounted.yaml
pod/configmap-mani-pod-mounted created
```

---

```bash
kubectl exec -it configmap-mani-pod-mounted -- /bin/bash

---

root@configmap-mani-pod-mounted:/# ls -l /etc/config/
total 0
lrwxrwxrwx 1 root root 11 Apr 27 23:03 lala -> ..data/lala
root@configmap-mani-pod-mounted:/# ls -l /etc/config/

root@configmap-mani-pod-mounted:/# ls -la /etc/config/
total 16
drwxrwxrwx 3 root root 4096 Apr 27 23:03 .
drwxr-xr-x 1 root root 4096 Apr 27 23:03 ..
drwxr-xr-x 2 root root 4096 Apr 27 23:03 ..2024_04_27_23_03_24.3513899712
lrwxrwxrwx 1 root root   32 Apr 27 23:03 ..data -> ..2024_04_27_23_03_24.3513899712
lrwxrwxrwx 1 root root   11 Apr 27 23:03 lala -> ..data/lala

root@configmap-mani-pod-mounted:/# ls -l /etc/config/lala
lrwxrwxrwx 1 root root 11 Apr 27 23:03 /etc/config/lala -> ..data/lala

root@configmap-mani-pod-mounted:/# cat /etc/config/lala
paloozaroot@configmap-mani-pod-mounted:/# cat /etc/config/lala
```


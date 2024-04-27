
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

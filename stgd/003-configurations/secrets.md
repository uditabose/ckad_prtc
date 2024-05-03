# Creating Secret

## Table of content

- [Creating Secret](#creating-secret)
  - [Table of content](#table-of-content)
  - [Types](#types)
  - [From where](#from-where)
    - [Literal valus](#literal-valus)
    - [From env file](#from-env-file)
    - [From a file](#from-a-file)

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


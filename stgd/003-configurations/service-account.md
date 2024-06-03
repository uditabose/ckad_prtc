# Service Account

Pods may need to communicate with API server. Pod uses Service Account to authenticate itself to call the API server.

Kube admin assigns rules via role-based-access-control (RBAC) to authorize access to specific resources and actions.

Pods already use the `default` Service Account, whose access is same as unauthenticated user.

## Table of content  <!-- omit in toc -->

- [Service Account](#service-account)
  - [List all service account](#list-all-service-account)
  - [Get default service account details](#get-default-service-account-details)
  - [Run a Pod in default service account](#run-a-pod-in-default-service-account)
  - [Create custom service account](#create-custom-service-account)
    - [Create a Pod with inline assignment of service account](#create-a-pod-with-inline-assignment-of-service-account)
    - [Create Pod with service account from YAML](#create-pod-with-service-account-from-yaml)
      - [Verify Pod with service account](#verify-pod-with-service-account)
  - [Teardown](#teardown)

## List all service account

```bash
kubectl get serviceaccounts
---
NAME      SECRETS   AGE
default   0         54d
```

## Get default service account details

```bash
kubectl get serviceaccount default -o json
---
{
    "apiVersion": "v1",
    "kind": "ServiceAccount",
    "metadata": {
        "creationTimestamp": "2024-04-10T14:47:35Z",
        "name": "default",
        "namespace": "default",
        "resourceVersion": "348",
        "uid": "14c465b6-dd07-44ca-9e0f-766f8ae6b940"
    }
}
```

---

```bash
kubectl get serviceaccount default -o yaml
---
apiVersion: v1
kind: ServiceAccount
metadata:
  creationTimestamp: "2024-04-10T14:47:35Z"
  name: default
  namespace: default
  resourceVersion: "348"
  uid: 14c465b6-dd07-44ca-9e0f-766f8ae6b940
```

## Run a Pod in default service account

```bash
kubectl run nginx --image=nginx --restart=Never
pod/nginx created
```

```bash
kubectl get pod nginx -o yaml > stgd/003-configurations/service-account/nginx-pod-dump.yaml
kubectl get pod nginx -o json > stgd/003-configurations/service-account/nginx-pod-dump.json
---
kubectl get pod nginx -o json | jq .spec.serviceAccount
"default"
```

## Create custom service account

```bash
kubectl create serviceaccount custom
serviceaccount/custom created
```

### Create a Pod with inline assignment of service account

```bash
kubectl run nginx --image=nginx --restart=Never --serviceaccount=custom
error: unknown flag: --serviceaccount
See 'kubectl run --help' for usage.
FAIL: 1
```

### Create Pod with service account from YAML

```bash
kubectl create -f stgd/003-configurations/service-account/service-account-pod.yaml
pod/service-account-pod created
```

#### Verify Pod with service account

```bash
kubectl get pod service-account-pod -o json > stgd/003-configurations/service-account/service-account-pod-details.json
---

kubectl get pod service-account-pod -o json | jq .spec.serviceAccount
"custom"
```


## Teardown

```bash
kubectl delete pod service-account-pod --force --grace-period=0
Warning: Immediate deletion does not wait for confirmation that the running resource has been terminated. The resource may continue to run on the cluster indefinitely.
pod "service-account-pod" force deleted
```

# Resource Boundary

## Table of content  <!-- omit in toc -->

- [Resource Boundary](#resource-boundary)
  - [Creating ResourceQuota](#creating-resourcequota)
    - [Create a namespace](#create-a-namespace)
    - [Create ResourceQuota for namespace](#create-resourcequota-for-namespace)
    - [Create a Pod without limits in the quota namespace](#create-a-pod-without-limits-in-the-quota-namespace)
    - [Create a Pod with limits in the quota namespace](#create-a-pod-with-limits-in-the-quota-namespace)
      - [Copy pod yamls to create more pods](#copy-pod-yamls-to-create-more-pods)

## Creating ResourceQuota

- setting upper limit for number of objects that can be created for a specific type
- limiting total sum compute resource (ram, cpu)
- expecting a quality of service class for a Pod

### Create a namespace

```bash
kubectl create namespace team-awesome
namespace/team-awesome created

kubectl get namespace
```

### Create ResourceQuota for namespace

```bash
kubectl create -f stgd/003-configurations/resource-quota/resource_quota_awesome_quota.yaml --namespace=team-awesome
resourcequota/awesome-quota created

kubectl describe resourcequota awesome-quota --namespace=team-awesome
---
Name:            awesome-quota
Namespace:       team-awesome
Resource         Used  Hard
--------         ----  ----
limits.cpu       0     4
limits.memory    0     4096m
pods             0     2
requests.cpu     0     1
requests.memory  0     1024m
```

### Create a Pod without limits in the quota namespace

```bash
kubectl create -f stgd/003-configurations/resource-quota/resource_quota_pod_no_quota.yaml --namespace=team-awesome
---

Error from server (Forbidden): error when creating "stgd/003-configurations/resource-quota/resource_quota_pod_no_quota.yaml": pods "awesome-quota-pod" is forbidden: failed quota: awesome-quota: must specify limits.cpu for: awesome-quota-pod; limits.memory for: awesome-quota-pod; requests.cpu for: awesome-quota-pod; requests.memory for: awesome-quota-pod
FAIL: 1

```

### Create a Pod with limits in the quota namespace

```bash
kubectl create -f stgd/003-configurations/resource-quota/resource_quota_pod_with_quota.yaml --namespace=team-awesome
---
Warning: spec.containers[0].resources.limits[memory]: fractional byte value "1024m" is invalid, must be an integer
Warning: spec.containers[0].resources.requests[memory]: fractional byte value "512m" is invalid, must be an integer
pod/awesome-quota-pod created
```

```bash
kubectl describe pod/awesome-quota-pod --namespace=team-awesome > stgd/003-configurations/resource-quota/resource_quota_pod_with_quota.txt
```

#### Copy pod yamls to create more pods

```bash
cp stgd/003-configurations/resource-quota/resource_quota_pod_with_quota.yaml stgd/003-configurations/resource-quota/resource_quota_pod_2_with_quota.yaml

cp stgd/003-configurations/resource-quota/resource_quota_pod_with_quota.yaml stgd/003-configurations/resource-quota/resource_quota_pod_3_with_quota.yaml
```

---

```bash
kubectl create -f stgd/003-configurations/resource-quota/resource_quota_pod_2_with_quota.yaml --namespace=team-awesome

Warning: spec.containers[0].resources.limits[memory]: fractional byte value "1024m" is invalid, must be an integer
Warning: spec.containers[0].resources.requests[memory]: fractional byte value "512m" is invalid, must be an integer
Error from server (Forbidden): error when creating "stgd/003-configurations/resource-quota/resource_quota_pod_2_with_quota.yaml": pods "awesome-quota-pod-2" is forbidden: exceeded quota: awesome-quota, requested: pods=1,requests.cpu=500m,requests.memory=512m, used: pods=2,requests.cpu=1,requests.memory=1024m, limited: pods=2,requests.cpu=1,requests.memory=1024m
FAIL: 1

---

kubectl create -f stgd/003-configurations/resource-quota/resource_quota_pod_3_with_quota.yaml --namespace=team-awesome
Warning: spec.containers[0].resources.limits[memory]: fractional byte value "1024m" is invalid, must be an integer
Warning: spec.containers[0].resources.requests[memory]: fractional byte value "512m" is invalid, must be an integer
Error from server (Forbidden): error when creating "stgd/003-configurations/resource-quota/resource_quota_pod_3_with_quota.yaml": pods "awesome-quota-pod-3" is forbidden: exceeded quota: awesome-quota, requested: pods=1,requests.cpu=500m,requests.memory=512m, used: pods=2,requests.cpu=1,requests.memory=1024m, limited: pods=2,requests.cpu=1,requests.memory=1024m
FAIL: 1
```

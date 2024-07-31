# Deployment

Deployment is how a application scales up and down. Undelying, uses `ReplicaSet`. `ReplicaSet` is responsible
to replicate a guaranteed number of Pods with s

## Table of Content  <!-- omit in toc -->

- [Deployment](#deployment)
  - [Create Deployment via Command-line](#create-deployment-via-command-line)
    - [Verify basic deployment](#verify-basic-deployment)
  - [Create Deployment via Manifest](#create-deployment-via-manifest)
    - [Verify manifest deployment](#verify-manifest-deployment)
  - [Get all deployments](#get-all-deployments)
  - [Rolling out a new revision](#rolling-out-a-new-revision)
    - [Verify rollout](#verify-rollout)
  - [Rolling back](#rolling-back)
    - [Verify rolling back](#verify-rolling-back)
  - [Teardown](#teardown)

## Create Deployment via Command-line

```bash
kubectl create deployment first-deploy --image=nginx:1.14.2
deployment.apps/first-deploy created
```

### Verify basic deployment

```bash
kubectl describe deployments/first-deploy > stgd/006-pod-design/deployments/first-deploy-desc.txt

kubectl get deployments/first-deploy -o json > stgd/006-pod-design/deployments/first-deploy-desc.json
```

## Create Deployment via Manifest

```bash
kubectl create -f stgd/006-pod-design/deployments/second-deploy.yaml
deployment.apps/second-deploy created
```

### Verify manifest deployment

```bash
kubectl describe deployments/second-deploy > stgd/006-pod-design/deployments/second-deploy-desc.txt

kubectl get deployments/second-deploy -o json > stgd/006-pod-design/deployments/second-deploy-desc.json
```

## Get all deployments

```bash
kubectl get deployments
---
NAME            READY   UP-TO-DATE   AVAILABLE   AGE
first-deploy    1/1     1            1           16m
second-deploy   1/1     1            1           3m20s
```

## Rolling out a new revision

Deployment keeps a history of Rollouts. New version of rollout is called `revision`.

```bash
kubectl rollout history deployment second-deploy
---
deployment.apps/second-deploy 
REVISION  CHANGE-CAUSE
1         <none>
```

```bash
kubectl set image deployment second-deploy second-deploy=nginx:1.19.2
deployment.apps/second-deploy image updated
```

### Verify rollout

```bash
kubectl rollout history deployment second-deploy
deployment.apps/second-deploy 
REVISION  CHANGE-CAUSE
1         <none>
2         <none>
```

```bash
kubectl rollout status deployment second-deploy
deployment "second-deploy" successfully rolled out
```

```bash
kubectl rollout history deployment second-deploy --revision=2
---
deployment.apps/second-deploy with revision #2
Pod Template:
  Labels:       app=second-deploy
        pod-template-hash=7bc85ccc49
  Containers:
   second-deploy:
    Image:      nginx:1.19.2
    Port:       9797/TCP
    Host Port:  0/TCP
    Limits:
      cpu:      500m
      memory:   128Mi
    Environment:        <none>
    Mounts:     <none>
  Volumes:      <none>  
```

## Rolling back

```bash
kubectl rollout undo deployment second-deploy --to-revision=1
deployment.apps/second-deploy rolled back
```

### Verify rolling back

```bash
kubectl rollout history deployment second-deploy
---
deployment.apps/second-deploy 
REVISION  CHANGE-CAUSE
2         <none>
3         <none>
```

```bash

kubectl rollout history deployment second-deploy --revision=3
deployment.apps/second-deploy with revision #3
Pod Template:
  Labels:       app=second-deploy
        pod-template-hash=79479b98d
  Containers:
   second-deploy:
    Image:      nginx:1.14.2
    Port:       9797/TCP
    Host Port:  0/TCP
    Limits:
      cpu:      500m
      memory:   128Mi
    Environment:        <none>
    Mounts:     <none>
  Volumes:      <none>

```

## Teardown

```bash
kubectl delete deployments/first-deploy --force --grace-period=0
deployment.apps "first-deploy" force deleted

---
kubectl delete deployments/second-deploy --force --grace-period=0
deployment.apps "second-deploy" force deleted
```

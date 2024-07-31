# Scaling

Scaling up/down a deployment

## Table of Content  <!-- omit in toc -->

- [Scaling](#scaling)
  - [Manually scaling a deployment](#manually-scaling-a-deployment)
    - [Verify scaling command](#verify-scaling-command)
  - [Autoscaling](#autoscaling)
    - [Horizontal Pod Autoscaler (HPA)](#horizontal-pod-autoscaler-hpa)
    - [Verify HPA](#verify-hpa)
    - [Vertical Pod Autoscaler](#vertical-pod-autoscaler)
  - [Teardown](#teardown)

## Manually scaling a deployment

```bash
kubectl create -f stgd/006-pod-design/scaling/scaling-deploy.yaml
deployment.apps/scaling-deploy created
```

```bash
kubectl scale deployment scaling-deploy --replicas=5
deployment.apps/scaling-deploy scaled
```

### Verify scaling command

```bash
kubectl get pods
----
NAME                             READY   STATUS                       RESTARTS          AGE
configmap-mani-pod               1/1     Running                      7 (4d18h ago)     93d
configmap-mani-pod-mounted       1/1     Running                      7 (4d18h ago)     93d
configmap-pod                    1/1     Running                      7 (4d18h ago)     93d
fs-secured                       1/1     Running                      6 (4d18h ago)     68d
incorrect-cmd-pod                0/1     CrashLoopBackOff             3965 (103s ago)   37d
nginx                            0/1     Error                        0                 57d
non-root                         0/1     CreateContainerConfigError   0                 68d
scaling-deploy-55c44b8dd-254pt   1/1     Running                      0                 84s
scaling-deploy-55c44b8dd-68lkw   1/1     Running                      0                 38s
scaling-deploy-55c44b8dd-hqn2b   1/1     Running                      0                 38s
scaling-deploy-55c44b8dd-jx2d4   1/1     Running                      0                 38s
scaling-deploy-55c44b8dd-mb7j5   1/1     Running                      0                 38s
secrets-mounted-pod              1/1     Running                      5 (4d18h ago)     71d
secrets-pod                      1/1     Running                      5 (4d18h ago)     71d
```

```bash
kubectl describe deployment.apps/scaling-deploy > stgd/006-pod-design/scaling/scaling-deploy-desc.txt
```

## Autoscaling

Auto-scaler is scales up deployment depending on scaling up strategy.

Two types of auto-scalers -

### Horizontal Pod Autoscaler (HPA)

Scales the number of Pods replicas based on CPU and Memory threshold. HPA is standard.

```bash
kubectl autoscale deployment scaling-deploy --cpu-percent=70 --min=2 --max=8
horizontalpodautoscaler.autoscaling/scaling-deploy autoscaled
```

### Verify HPA

```bash
kubectl get hpa
NAME             REFERENCE                   TARGETS         MINPODS   MAXPODS   REPLICAS   AGE
scaling-deploy   Deployment/scaling-deploy   <unknown>/70%   2         8         0          33s
```

```bash
kubectl describe hpa scaling-deploy > stgd/006-pod-design/scaling/scaling-deploy-hpa-desc.txt
---
Name:                                                  scaling-deploy
Namespace:                                             default
Labels:                                                <none>
Annotations:                                           <none>
CreationTimestamp:                                     Wed, 31 Jul 2024 12:07:31 -0400
Reference:                                             Deployment/scaling-deploy
Metrics:                                               ( current / target )
  resource cpu on pods  (as a percentage of request):  <unknown> / 70%
Min replicas:                                          2
Max replicas:                                          8
Deployment pods:                                       5 current / 0 desired
Conditions:
  Type           Status  Reason                   Message
  ----           ------  ------                   -------
  AbleToScale    True    SucceededGetScale        the HPA controller was able to get the target's current scale
  ScalingActive  False   FailedGetResourceMetric  the HPA was unable to compute the replica count: failed to get cpu utilization: unable to get metrics for resource cpu: unable to fetch metrics from resource metrics API: the server could not find the requested resource (get pods.metrics.k8s.io)
Events:
  Type     Reason                        Age                  From                       Message
  ----     ------                        ----                 ----                       -------
  Warning  FailedGetResourceMetric       54s (x3 over 2m54s)  horizontal-pod-autoscaler  failed to get cpu utilization: unable to get metrics for resource cpu: unable to fetch metrics from resource metrics API: the server could not find the requested resource (get pods.metrics.k8s.io)
  Warning  FailedComputeMetricsReplicas  54s (x3 over 2m54s)  horizontal-pod-autoscaler  invalid metrics (1 invalid out of 1), first error is: failed to get cpu resource metric value: failed to get cpu utilization: unable to get metrics for resource cpu: unable to fetch metrics from resource metrics API: the server could not find the requested resource (get pods.metrics.k8s.io)
```

### Vertical Pod Autoscaler

Scales the CPU and memory allocation for existing Pods based on historic metrics. 
Cloud providers provide this.

## Teardown

```bash
kubectl delete deployment.apps/scaling-deploy --force --grace-period=0
```

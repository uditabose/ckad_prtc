# Jobs

Job is Kuberenetes primitive, that runs till specified number of completions has reached.

## Table of Content  <!-- omit in toc -->

- [Jobs](#jobs)
  - [Create Job, command line](#create-job-command-line)
    - [Verify command line job](#verify-command-line-job)
  - [Job via yaml](#job-via-yaml)
    - [Verify yaml joob](#verify-yaml-joob)
  - [Job Operation Types](#job-operation-types)
  - [Creating CronJob](#creating-cronjob)
    - [Verify simple cronjob](#verify-simple-cronjob)
  - [Create Cronjob via YAML](#create-cronjob-via-yaml)
    - [Verify YAML Cronjob](#verify-yaml-cronjob)
  - [Teardown](#teardown)

## Create Job, command line

```bash
kubectl create job counter --image=nginx -- /bin/bash -c 'counter=0; \
while [[ $counter -lt 3 ]]; do counter=$((counter+1)); echo "$counter"; \
sleep 3; done;'
---
job.batch/counter created
```

### Verify command line job

```bash
kubectl get jobs
---
NAME      COMPLETIONS   DURATION   AGE
counter   1/1           4s         38s
```

```bash
kubectl get pods | grep counter
...
counter-2z69s                1/1     Running                      06s
---

kubectl logs counter-2z69s
1
2
3
```

## Job via yaml

```bash
kubectl create -f stgd/006-pod-design/jobs/counting-job.yaml
job.batch/counting-job created
```

### Verify yaml joob

```bash
kubectl get jobs
---
NAME           COMPLETIONS   DURATION   AGE
counter        1/1           13s        35m
counting-job   1/1           3s         39s
```

```bash
kubectl get pods | grep counting-job
counting-job-f8w7c           0/1     Completed
---

kubectl logs counting-job-f8w7c
```

## Job Operation Types

```bash
kubectl get jobs counter -o json | jq .spec.completions

kubectl get jobs counter -o json | jq .spec

kubectl get jobs counter -o json | jq ".spec | keys"
[
  "backoffLimit",
  "completionMode",
  "completions",
  "manualSelector",
  "parallelism",
  "podReplacementPolicy",
  "selector",
  "suspend",
  "template"
]
```

## Creating CronJob

> [crontab](https://crontab.guru/)
> minute hour day(month) month day(week)

```bash
kubectl create cronjob current-date --schedule="* * * * *" --image=nginx \
-- /bin/sh -c 'echo "Current date: $(date)"'

cronjob.batch/current-date created
```

### Verify simple cronjob

```bash
kubectl get cronjob
---
NAME           SCHEDULE    SUSPEND   ACTIVE   LAST SCHEDULE   AGE
current-date   * * * * *   False     0        6s              34s
```

```bash
kubectl get pods | grep current-date
current-date-28707975-88kwg   0/1     Completed                    0                  2m18s
current-date-28707976-p9n58   0/1     Completed                    0                  78s
current-date-28707977-zc25w   0/1     Completed                    0                  18s
```

```bash
pods=$(kubectl get --no-headers=true pods -o name | grep current-date)

kubectl logs current-date-28707983-dzlsn
Current date: Thu Aug  1 02:23:00 UTC 2024
```

## Create Cronjob via YAML

```bash
kubectl create -f stgd/006-pod-design/jobs/dating-cronjob.yaml
cronjob.batch/dating-cronjob created
```

### Verify YAML Cronjob

```bash
kubectl get cronjob
---
NAME             SCHEDULE    SUSPEND   ACTIVE   LAST SCHEDULE   AGE
current-date     * * * * *   False     0        19s             24m
dating-cronjob   * * * * *   False     0        19s             46s
```

```bash
kubectl get pods | grep dating-cronjob
dating-cronjob-28707999-7827t   0/1     Completed                    0                47s
dating-cronjob-28707999-hsr25   0/1     Completed                    0                43s
dating-cronjob-28707999-q8s7s   0/1     Completed                    0                47s
dating-cronjob-28707999-t8gjm   0/1     Completed                    0                47s
```

```bash
pods=$(kubectl get --no-headers=true pods -o name | grep current-date)

kubectl logs dating-cronjob-28707999-7827t
Thu Aug  1 02:39:01 UTC 2024
Hello from the Kubernetes cluster
```

```bash
kubectl describe cronjob/dating-cronjob > stgd/006-pod-design/jobs/dating-cronjob-desc.txt
kubectl get cronjob/dating-cronjob -o json > stgd/006-pod-design/jobs/dating-cronjob-desc.json
```
 
```bash
kubectl get cronjob/dating-cronjob -o json | jq ".spec | keys"
[
  "concurrencyPolicy",
  "failedJobsHistoryLimit",
  "jobTemplate",
  "schedule",
  "successfulJobsHistoryLimit",
  "suspend"
]
```

## Teardown

```bash
kubectl delete jobs/counter --force --grace-period=0
Warning: Immediate deletion does not wait for confirmation that the running resource has been terminated. The resource may continue to run on the cluster indefinitely.
job.batch "counter" force deleted
```

```bash
kubectl delete jobs/counting-job --force --grace-period=0
Warning: Immediate deletion does not wait for confirmation that the running resource has been terminated. The resource may continue to run on the cluster indefinitely.
job.batch "counter" force deleted
```

```bash
kubectl delete jobs/current-date --force --grace-period=0
```

```bash
kubectl delete jobs/dating-cronjob --force --grace-period=0
```

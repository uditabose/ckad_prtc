# Practice: Pods

You don't get what you wish for. You get what you work for.

## Table of Contents  <!-- omit in toc -->

- [Practice: Pods](#practice-pods)
  - [Run down](#run-down)

## Run down

```bash
      Welcome to the KodeKloud Hands-On lab                                                   
    __ ______  ____  ________ __ __    ____  __  ______ 
   / //_/ __ \/ __ \/ ____/ //_// /   / __ \/ / / / __ \
  / ,< / / / / / / / __/ / ,<  / /   / / / / / / / / / /
 / /| / /_/ / /_/ / /___/ /| |/ /___/ /_/ / /_/ / /_/ / 
/_/ |_\____/_____/_____/_/ |_/_____/\____/\____/_____/  
                                                        
          All rights reserved                                                                 

controlplane ~ ➜  kubectl get pods
No resources found in default namespace.

controlplane ~ ➜  kubectl run nginx-pod --image=nginx
pod/nginx-pod created

controlplane ~ ➜  kubectl get pods
NAME            READY   STATUS    RESTARTS   AGE
nginx-pod       1/1     Running   0          25s
newpods-grvhv   1/1     Running   0          9s
newpods-qvndm   1/1     Running   0          9s
newpods-gcbrs   1/1     Running   0          9s

controlplane ~ ➜  kubectl get pods newpods-gcbrs 
NAME            READY   STATUS    RESTARTS   AGE
newpods-gcbrs   1/1     Running   0          67s

controlplane ~ ➜  kubectl describe pods newpods-gcbrs 
Name:             newpods-gcbrs
Namespace:        default
Priority:         0
Service Account:  default
Node:             controlplane/192.33.46.9
Start Time:       Fri, 09 Aug 2024 15:17:33 +0000
Labels:           tier=busybox
Annotations:      <none>
Status:           Running
IP:               10.42.0.12
IPs:
  IP:           10.42.0.12
Controlled By:  ReplicaSet/newpods
Containers:
  busybox:
    Container ID:  containerd://2ed90f80c22aec282b7d425aba6ede4e6c4ca4596f0a1b5a5d7fd41f276885af
    Image:         busybox
    Image ID:      docker.io/library/busybox@sha256:9ae97d36d26566ff84e8893c64a6dc4fe8ca6d1144bf5b87b2b85a32def253c7
    Port:          <none>
    Host Port:     <none>
    Command:
      sleep
      1000
    State:          Running
      Started:      Fri, 09 Aug 2024 15:17:35 +0000
    Ready:          True
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-6p6kp (ro)
Conditions:
  Type                        Status
  PodReadyToStartContainers   True 
  Initialized                 True 
  Ready                       True 
  ContainersReady             True 
  PodScheduled                True 
Volumes:
  kube-api-access-6p6kp:
    Type:                    Projected (a volume that contains injected data from multiple sources)
    TokenExpirationSeconds:  3607
    ConfigMapName:           kube-root-ca.crt
    ConfigMapOptional:       <nil>
    DownwardAPI:             true
QoS Class:                   BestEffort
Node-Selectors:              <none>
Tolerations:                 node.kubernetes.io/not-ready:NoExecute op=Exists for 300s
                             node.kubernetes.io/unreachable:NoExecute op=Exists for 300s
Events:
  Type    Reason     Age   From               Message
  ----    ------     ----  ----               -------
  Normal  Scheduled  74s   default-scheduler  Successfully assigned default/newpods-gcbrs to controlplane
  Normal  Pulling    73s   kubelet            Pulling image "busybox"
  Normal  Pulled     73s   kubelet            Successfully pulled image "busybox" in 156ms (156ms including waiting). Image size: 4496154 bytes.
  Normal  Created    73s   kubelet            Created container busybox
  Normal  Started    72s   kubelet            Started container busybox

controlplane ~ ➜  
```

newpods-grvhv   1/1     Running   0          9s
newpods-qvndm   1/1     Running   0          9s
newpods-gcbrs 

1. `kubectl get pods -n kube-system`
```
ETCDCTL_API=3 etcdctl --endpoints=https://127.0.0.1:2379 \
                      --cacert=/etc/kubernetes/pki/etcd/ca.crt \
                      --cert=/etc/kubernetes/pki/etcd/server.crt \
                      --key=/etc/kubernetes/pki/etcd/server.key \
snapshot save ./etcd-backup/etcdbackup.db
```

```
kubectl get secrets/database-data --namespace=database-ns -o json | jq '.data | map_values(@base64d)' > decoded.txt
```

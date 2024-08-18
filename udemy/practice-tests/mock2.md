       Welcome to the KodeKloud Hands-On lab                                                                         
    __ ______  ____  ________ __ __    ____  __  ______ 
   / //_/ __ \/ __ \/ ____/ //_// /   / __ \/ / / / __ \
  / ,< / / / / / / / __/ / ,<  / /   / / / / / / / / / /
 / /| / /_/ / /_/ / /___/ /| |/ /___/ /_/ / /_/ / /_/ / 
/_/ |_\____/_____/_____/_/ |_/_____/\____/\____/_____/  
                                                        
            All rights reserved                                                                                      

controlplane ~ ➜  ETCDCTL_API=3 etcdctl --endpoints=https://127.0.0.1:2379 \
                      --cacert=/etc/kubernetes/pki/etcd/ca.crt \
                      --cert=/etc/kubernetes/pki/etcd/server.crt \
                      --key=/etc/kubernetes/pki/etcd/server.key \
snapshot save /opt/etcd-backup.db
Snapshot saved at /opt/etcd-backup.db

controlplane ~ ➜  kubectl run redis-storage --image=redis:alpine --dry-run=client -o yaml > redis-storage .yaml

controlplane ~ ➜  mv "redis-storage .yaml" "redis-storage.yaml"
mv: cannot stat 'redis-storage .yaml': No such file or directory

controlplane ~ ✖ ls -l
total 11028
drwxr-xr-x 2 root  root      4096 Aug 16 16:02 CKA
drwxr-xr-x 3 admin admin     4096 Feb 12  2018 etcd-v3.3.1-linux-amd64
-rw-r--r-- 1 root  root  11276406 Aug 16 16:02 etcd-v3.3.1-linux-amd64.tar.gz
-rw-r--r-- 1 root  root       285 Aug 16 16:05 redis-storage
-rw-r--r-- 1 root  root         0 Jul 12 15:51 sample.yaml

controlplane ~ ➜  mv "redis-storage" "redis-storage.yaml"

controlplane ~ ➜  vi redis-storage.yaml

controlplane ~ ➜  kubectl create -f redis-storage.yaml
pod/redis-storage created

controlplane ~ ➜  kubectl get pod -o json
{
    "apiVersion": "v1",
    "items": [
        {
            "apiVersion": "v1",
            "kind": "Pod",
            "metadata": {
                "creationTimestamp": "2024-08-16T16:07:16Z",
                "labels": {
                    "run": "redis-storage"
                },
                "name": "redis-storage",
                "namespace": "default",
                "resourceVersion": "2263",
                "uid": "c966458c-8ba4-4d60-85c1-e0f5f27a7671"
            },
            "spec": {
                "containers": [
                    {
                        "args": [
                            ".yaml"
                        ],
                        "image": "redis:alpine",
                        "imagePullPolicy": "IfNotPresent",
                        "name": "redis-storage",
                        "resources": {},
                        "terminationMessagePath": "/dev/termination-log",
                        "terminationMessagePolicy": "File",
                        "volumeMounts": [
                            {
                                "mountPath": "/var/run/secrets/kubernetes.io/serviceaccount",
                                "name": "kube-api-access-zd9t9",
                                "readOnly": true
                            }
                        ]
                    }
                ],
                "dnsPolicy": "ClusterFirst",
                "enableServiceLinks": true,
                "nodeName": "node01",
                "preemptionPolicy": "PreemptLowerPriority",
                "priority": 0,
                "restartPolicy": "Always",
                "schedulerName": "default-scheduler",
                "securityContext": {},
                "serviceAccount": "default",
                "serviceAccountName": "default",
                "terminationGracePeriodSeconds": 30,
                "tolerations": [
                    {
                        "effect": "NoExecute",
                        "key": "node.kubernetes.io/not-ready",
                        "operator": "Exists",
                        "tolerationSeconds": 300
                    },
                    {
                        "effect": "NoExecute",
                        "key": "node.kubernetes.io/unreachable",
                        "operator": "Exists",
                        "tolerationSeconds": 300
                    }
                ],
                "volumes": [
                    {
                        "emptyDir": {},
                        "name": "data-volume"
                    },
                    {
                        "name": "kube-api-access-zd9t9",
                        "projected": {
                            "defaultMode": 420,
                            "sources": [
                                {
                                    "serviceAccountToken": {
                                        "expirationSeconds": 3607,
                                        "path": "token"
                                    }
                                },
                                {
                                    "configMap": {
                                        "items": [
                                            {
                                                "key": "ca.crt",
                                                "path": "ca.crt"
                                            }
                                        ],
                                        "name": "kube-root-ca.crt"
                                    }
                                },
                                {
                                    "downwardAPI": {
                                        "items": [
                                            {
                                                "fieldRef": {
                                                    "apiVersion": "v1",
                                                    "fieldPath": "metadata.namespace"
                                                },
                                                "path": "namespace"
                                            }
                                        ]
                                    }
                                }
                            ]
                        }
                    }
                ]
            },
            "status": {
                "conditions": [
                    {
                        "lastProbeTime": null,
                        "lastTransitionTime": "2024-08-16T16:07:21Z",
                        "status": "True",
                        "type": "PodReadyToStartContainers"
                    },
                    {
                        "lastProbeTime": null,
                        "lastTransitionTime": "2024-08-16T16:07:16Z",
                        "status": "True",
                        "type": "Initialized"
                    },
                    {
                        "lastProbeTime": null,
                        "lastTransitionTime": "2024-08-16T16:07:16Z",
                        "message": "containers with unready status: [redis-storage]",
                        "reason": "ContainersNotReady",
                        "status": "False",
                        "type": "Ready"
                    },
                    {
                        "lastProbeTime": null,
                        "lastTransitionTime": "2024-08-16T16:07:16Z",
                        "message": "containers with unready status: [redis-storage]",
                        "reason": "ContainersNotReady",
                        "status": "False",
                        "type": "ContainersReady"
                    },
                    {
                        "lastProbeTime": null,
                        "lastTransitionTime": "2024-08-16T16:07:16Z",
                        "status": "True",
                        "type": "PodScheduled"
                    }
                ],
                "containerStatuses": [
                    {
                        "containerID": "containerd://8c53372f890dcb300300d59f9f40c3c003dcfc44b1cc88159b22ae26b3a49929",
                        "image": "docker.io/library/redis:alpine",
                        "imageID": "docker.io/library/redis@sha256:eaea8264f74a95ea9a0767c794da50788cbd9cf5223951674d491fa1b3f4f2d2",
                        "lastState": {
                            "terminated": {
                                "containerID": "containerd://8c53372f890dcb300300d59f9f40c3c003dcfc44b1cc88159b22ae26b3a49929",
                                "exitCode": 127,
                                "finishedAt": "2024-08-16T16:07:22Z",
                                "reason": "Error",
                                "startedAt": "2024-08-16T16:07:22Z"
                            }
                        },
                        "name": "redis-storage",
                        "ready": false,
                        "restartCount": 1,
                        "started": false,
                        "state": {
                            "waiting": {
                                "message": "back-off 10s restarting failed container=redis-storage pod=redis-storage_default(c966458c-8ba4-4d60-85c1-e0f5f27a7671)",
                                "reason": "CrashLoopBackOff"
                            }
                        }
                    }
                ],
                "hostIP": "192.34.160.11",
                "hostIPs": [
                    {
                        "ip": "192.34.160.11"
                    }
                ],
                "phase": "Running",
                "podIP": "10.244.192.1",
                "podIPs": [
                    {
                        "ip": "10.244.192.1"
                    }
                ],
                "qosClass": "BestEffort",
                "startTime": "2024-08-16T16:07:16Z"
            }
        }
    ],
    "kind": "List",
    "metadata": {
        "resourceVersion": ""
    }
}

controlplane ~ ➜  kubectl get pod/redis-storage -o json
{
    "apiVersion": "v1",
    "kind": "Pod",
    "metadata": {
        "creationTimestamp": "2024-08-16T16:07:16Z",
        "labels": {
            "run": "redis-storage"
        },
        "name": "redis-storage",
        "namespace": "default",
        "resourceVersion": "2289",
        "uid": "c966458c-8ba4-4d60-85c1-e0f5f27a7671"
    },
    "spec": {
        "containers": [
            {
                "args": [
                    ".yaml"
                ],
                "image": "redis:alpine",
                "imagePullPolicy": "IfNotPresent",
                "name": "redis-storage",
                "resources": {},
                "terminationMessagePath": "/dev/termination-log",
                "terminationMessagePolicy": "File",
                "volumeMounts": [
                    {
                        "mountPath": "/var/run/secrets/kubernetes.io/serviceaccount",
                        "name": "kube-api-access-zd9t9",
                        "readOnly": true
                    }
                ]
            }
        ],
        "dnsPolicy": "ClusterFirst",
        "enableServiceLinks": true,
        "nodeName": "node01",
        "preemptionPolicy": "PreemptLowerPriority",
        "priority": 0,
        "restartPolicy": "Always",
        "schedulerName": "default-scheduler",
        "securityContext": {},
        "serviceAccount": "default",
        "serviceAccountName": "default",
        "terminationGracePeriodSeconds": 30,
        "tolerations": [
            {
                "effect": "NoExecute",
                "key": "node.kubernetes.io/not-ready",
                "operator": "Exists",
                "tolerationSeconds": 300
            },
            {
                "effect": "NoExecute",
                "key": "node.kubernetes.io/unreachable",
                "operator": "Exists",
                "tolerationSeconds": 300
            }
        ],
        "volumes": [
            {
                "emptyDir": {},
                "name": "data-volume"
            },
            {
                "name": "kube-api-access-zd9t9",
                "projected": {
                    "defaultMode": 420,
                    "sources": [
                        {
                            "serviceAccountToken": {
                                "expirationSeconds": 3607,
                                "path": "token"
                            }
                        },
                        {
                            "configMap": {
                                "items": [
                                    {
                                        "key": "ca.crt",
                                        "path": "ca.crt"
                                    }
                                ],
                                "name": "kube-root-ca.crt"
                            }
                        },
                        {
                            "downwardAPI": {
                                "items": [
                                    {
                                        "fieldRef": {
                                            "apiVersion": "v1",
                                            "fieldPath": "metadata.namespace"
                                        },
                                        "path": "namespace"
                                    }
                                ]
                            }
                        }
                    ]
                }
            }
        ]
    },
    "status": {
        "conditions": [
            {
                "lastProbeTime": null,
                "lastTransitionTime": "2024-08-16T16:07:21Z",
                "status": "True",
                "type": "PodReadyToStartContainers"
            },
            {
                "lastProbeTime": null,
                "lastTransitionTime": "2024-08-16T16:07:16Z",
                "status": "True",
                "type": "Initialized"
            },
            {
                "lastProbeTime": null,
                "lastTransitionTime": "2024-08-16T16:07:36Z",
                "message": "containers with unready status: [redis-storage]",
                "reason": "ContainersNotReady",
                "status": "False",
                "type": "Ready"
            },
            {
                "lastProbeTime": null,
                "lastTransitionTime": "2024-08-16T16:07:36Z",
                "message": "containers with unready status: [redis-storage]",
                "reason": "ContainersNotReady",
                "status": "False",
                "type": "ContainersReady"
            },
            {
                "lastProbeTime": null,
                "lastTransitionTime": "2024-08-16T16:07:16Z",
                "status": "True",
                "type": "PodScheduled"
            }
        ],
        "containerStatuses": [
            {
                "containerID": "containerd://ca3cd1ac09f65dad6289a59665bc2c04e29a529f5335311f0215dc6c6caea797",
                "image": "docker.io/library/redis:alpine",
                "imageID": "docker.io/library/redis@sha256:eaea8264f74a95ea9a0767c794da50788cbd9cf5223951674d491fa1b3f4f2d2",
                "lastState": {
                    "terminated": {
                        "containerID": "containerd://8c53372f890dcb300300d59f9f40c3c003dcfc44b1cc88159b22ae26b3a49929",
                        "exitCode": 127,
                        "finishedAt": "2024-08-16T16:07:22Z",
                        "reason": "Error",
                        "startedAt": "2024-08-16T16:07:22Z"
                    }
                },
                "name": "redis-storage",
                "ready": false,
                "restartCount": 2,
                "started": false,
                "state": {
                    "terminated": {
                        "containerID": "containerd://ca3cd1ac09f65dad6289a59665bc2c04e29a529f5335311f0215dc6c6caea797",
                        "exitCode": 127,
                        "finishedAt": "2024-08-16T16:07:34Z",
                        "reason": "Error",
                        "startedAt": "2024-08-16T16:07:34Z"
                    }
                }
            }
        ],
        "hostIP": "192.34.160.11",
        "hostIPs": [
            {
                "ip": "192.34.160.11"
            }
        ],
        "phase": "Running",
        "podIP": "10.244.192.1",
        "podIPs": [
            {
                "ip": "10.244.192.1"
            }
        ],
        "qosClass": "BestEffort",
        "startTime": "2024-08-16T16:07:16Z"
    }
}

controlplane ~ ➜  kubectl edit pod/redis-storage -o json
Edit cancelled, no changes made.

controlplane ~ ➜  kubectl delete pod/redis-storage  --force --grace-period=0
Warning: Immediate deletion does not wait for confirmation that the running resource has been terminated. The resource may continue to run on the cluster indefinitely.
pod "redis-storage" force deleted

controlplane ~ ➜  vi redis-storage.yaml 

controlplane ~ ➜  kubectl create -f redis-storage.yaml 
Error from server (BadRequest): error when creating "redis-storage.yaml": Pod in version "v1" cannot be handled as a Pod: json: cannot unmarshal object into Go struct field PodSpec.spec.containers of type []v1.Container

controlplane ~ ✖ vi redis-storage.yaml 

controlplane ~ ➜  rm redis-storage.yaml 

controlplane ~ ➜  vi redis-storage.yaml 

controlplane ~ ➜  kubectl create -f redis-storage.yaml 
pod/redis-storage created

controlplane ~ ➜  vi super-user-pod.yaml

controlplane ~ ➜  cat super-user-pod.yaml

apiVersion: v1
kind: Pod
metadata:
  name: super-user-pod
  namespace: default
spec:
  containers:
  - command:
    - sleep
    - "4800"
    image: busybox:1.28
    securityContext:
     capabilities:
        add: ["SYS_TIME"]
    name: super-user-pod

controlplane ~ ➜  cat redis-storage.yaml 

apiVersion: v1
kind: Pod
metadata:
  name: redis-storage
spec:
  containers:
  - image: redis:alpine
    name: redis-storage
    volumeMounts:
    - name: data-volume
      mountPath: /data/redis
  volumes:
  - name: data-volume
    emptyDir: {}


controlplane ~ ➜  kubectl create -f super-user-pod.yaml
pod/super-user-pod created

controlplane ~ ➜  kubectl get pod/super-user-pod  -o wide
NAME             READY   STATUS    RESTARTS   AGE   IP             NODE     NOMINATED NODE   READINESS GATES
super-user-pod   1/1     Running   0          13s   10.244.192.2   node01   <none>           <none>

controlplane ~ ➜  kubectl describe  pod/super-user-pod  
Name:             super-user-pod
Namespace:        default
Priority:         0
Service Account:  default
Node:             node01/192.34.160.11
Start Time:       Fri, 16 Aug 2024 16:16:07 +0000
Labels:           <none>
Annotations:      <none>
Status:           Running
IP:               10.244.192.2
IPs:
  IP:  10.244.192.2
Containers:
  super-user-pod:
    Container ID:  containerd://41ee48ba58c0203e652e94ef3c58ffb9c15b956150585446dbae46bf3563438e
    Image:         busybox:1.28
    Image ID:      docker.io/library/busybox@sha256:141c253bc4c3fd0a201d32dc1f493bcf3fff003b6df416dea4f41046e0f37d47
    Port:          <none>
    Host Port:     <none>
    Command:
      sleep
      4800
    State:          Running
      Started:      Fri, 16 Aug 2024 16:16:08 +0000
    Ready:          True
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-kfqhk (ro)
Conditions:
  Type                        Status
  PodReadyToStartContainers   True 
  Initialized                 True 
  Ready                       True 
  ContainersReady             True 
  PodScheduled                True 
Volumes:
  kube-api-access-kfqhk:
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
  Normal  Scheduled  29s   default-scheduler  Successfully assigned default/super-user-pod to node01
  Normal  Pulling    28s   kubelet            Pulling image "busybox:1.28"
  Normal  Pulled     28s   kubelet            Successfully pulled image "busybox:1.28" in 263ms (263ms including waiting). Image size: 727869 bytes.
  Normal  Created    28s   kubelet            Created container super-user-pod
  Normal  Started    28s   kubelet            Started container super-user-pod

controlplane ~ ➜  kubectl describe  pod/super-user-pod  | grep SYS_TIME

controlplane ~ ✖ kubectl get  pod/super-user-pod -o yaml  | grep SYS_TIME
        - SYS_TIME

controlplane ~ ➜  kubectl get  pod/super-user-pod -o yaml  | grep SYS_TIME -n10
11-  - command:
12-    - sleep
13-    - "4800"
14-    image: busybox:1.28
15-    imagePullPolicy: IfNotPresent
16-    name: super-user-pod
17-    resources: {}
18-    securityContext:
19-      capabilities:
20-        add:
21:        - SYS_TIME
22-    terminationMessagePath: /dev/termination-log
23-    terminationMessagePolicy: File
24-    volumeMounts:
25-    - mountPath: /var/run/secrets/kubernetes.io/serviceaccount
26-      name: kube-api-access-kfqhk
27-      readOnly: true
28-  dnsPolicy: ClusterFirst
29-  enableServiceLinks: true
30-  nodeName: node01
31-  preemptionPolicy: PreemptLowerPriority

controlplane ~ ➜  cat /root/CKA/use-pv.yaml
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: use-pv
  name: use-pv
spec:
  containers:
  - image: nginx
    name: use-pv
    resources: {}
  dnsPolicy: ClusterFirst
  restartPolicy: Always
status: {}

controlplane ~ ➜  kubectl get persistentVolumeClaim/my-pvc
Error from server (NotFound): persistentvolumeclaims "my-pvc" not found

controlplane ~ ✖ kubectl get persistentVolume/my-pv
Error from server (NotFound): persistentvolumes "my-pv" not found

controlplane ~ ✖ ls -l root/CKA
ls: cannot access 'root/CKA': No such file or directory

controlplane ~ ✖ ls -l /root/CKA
total 4
-rw-r--r-- 1 root root 235 Aug 16 16:19 use-pv.yaml

controlplane ~ ➜  vi pv-1.yaml

controlplane ~ ➜  kubectl create -f pv-1.yaml
Error from server (AlreadyExists): error when creating "pv-1.yaml": persistentvolumes "pv-1" already exists

controlplane ~ ✖ kubectl get persistentVolume/pv-1
NAME   CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS      CLAIM   STORAGECLASS   VOLUMEATTRIBUTESCLASS   REASON   AGE
pv-1   10Mi       RWO            Retain           Available                          <unset>                          4m56s

controlplane ~ ➜  vi my-pvc.yaml

controlplane ~ ➜  kubectl create -f my-pvc.yaml
persistentvolumeclaim/my-pvc created

controlplane ~ ➜  vi /root/CKA/use-pv.yaml

controlplane ~ ➜  kubectl create -f /root/CKA/use-pv.yaml
pod/use-pv created

controlplane ~ ➜  kubectl get pod/use-pv  -o json
{
    "apiVersion": "v1",
    "kind": "Pod",
    "metadata": {
        "creationTimestamp": "2024-08-16T16:26:42Z",
        "labels": {
            "run": "use-pv"
        },
        "name": "use-pv",
        "namespace": "default",
        "resourceVersion": "3938",
        "uid": "1dbd7db2-5275-43dc-b035-0c07eaa61f64"
    },
    "spec": {
        "containers": [
            {
                "image": "nginx",
                "imagePullPolicy": "Always",
                "name": "use-pv",
                "resources": {},
                "terminationMessagePath": "/dev/termination-log",
                "terminationMessagePolicy": "File",
                "volumeMounts": [
                    {
                        "mountPath": "/var/run/secrets/kubernetes.io/serviceaccount",
                        "name": "kube-api-access-rjn9z",
                        "readOnly": true
                    }
                ]
            }
        ],
        "dnsPolicy": "ClusterFirst",
        "enableServiceLinks": true,
        "preemptionPolicy": "PreemptLowerPriority",
        "priority": 0,
        "restartPolicy": "Always",
        "schedulerName": "default-scheduler",
        "securityContext": {},
        "serviceAccount": "default",
        "serviceAccountName": "default",
        "terminationGracePeriodSeconds": 30,
        "tolerations": [
            {
                "effect": "NoExecute",
                "key": "node.kubernetes.io/not-ready",
                "operator": "Exists",
                "tolerationSeconds": 300
            },
            {
                "effect": "NoExecute",
                "key": "node.kubernetes.io/unreachable",
                "operator": "Exists",
                "tolerationSeconds": 300
            }
        ],
        "volumes": [
            {
                "name": "pv-1",
                "persistentVolumeClaim": {
                    "claimName": "my-pvc"
                }
            },
            {
                "name": "kube-api-access-rjn9z",
                "projected": {
                    "defaultMode": 420,
                    "sources": [
                        {
                            "serviceAccountToken": {
                                "expirationSeconds": 3607,
                                "path": "token"
                            }
                        },
                        {
                            "configMap": {
                                "items": [
                                    {
                                        "key": "ca.crt",
                                        "path": "ca.crt"
                                    }
                                ],
                                "name": "kube-root-ca.crt"
                            }
                        },
                        {
                            "downwardAPI": {
                                "items": [
                                    {
                                        "fieldRef": {
                                            "apiVersion": "v1",
                                            "fieldPath": "metadata.namespace"
                                        },
                                        "path": "namespace"
                                    }
                                ]
                            }
                        }
                    ]
                }
            }
        ]
    },
    "status": {
        "conditions": [
            {
                "lastProbeTime": null,
                "lastTransitionTime": "2024-08-16T16:26:42Z",
                "message": "0/2 nodes are available: pod has unbound immediate PersistentVolumeClaims. preemption: 0/2 nodes are available: 2 Preemption is not helpful for scheduling.",
                "reason": "Unschedulable",
                "status": "False",
                "type": "PodScheduled"
            }
        ],
        "phase": "Pending",
        "qosClass": "BestEffort"
    }
}

controlplane ~ ➜  kubectl get pod/use-pv  -o wide
NAME     READY   STATUS    RESTARTS   AGE   IP       NODE     NOMINATED NODE   READINESS GATES
use-pv   0/1     Pending   0          29s   <none>   <none>   <none>           <none>

controlplane ~ ➜  kubectl create deployment nginx-deploy --image=nginx:1.16
deployment.apps/nginx-deploy created

controlplane ~ ➜  kubectl get deployment.apps/nginx-deploy -o wide
NAME           READY   UP-TO-DATE   AVAILABLE   AGE   CONTAINERS   IMAGES       SELECTOR
nginx-deploy   1/1     1            1           12s   nginx        nginx:1.16   app=nginx-deploy

controlplane ~ ➜  kubectl edit deployment nginx-deploy
deployment.apps/nginx-deploy edited

controlplane ~ ➜  kubectl edit deployment nginx-deploy
deployment.apps/nginx-deploy edited

controlplane ~ ➜  kubectl get deployment.apps/nginx-deploy -o wide
NAME           READY   UP-TO-DATE   AVAILABLE   AGE   CONTAINERS   IMAGES       SELECTOR
nginx-deploy   1/1     1            1           67s   nginx        nginx:1.17   app=nginx-deploy

controlplane ~ ➜  ls -l /root/CKA/john.csr
-rw-r--r-- 1 root root 883 Aug 16 16:30 /root/CKA/john.csr

controlplane ~ ➜  ls -l /root/CKA/
total 12
-rw-r--r-- 1 root root  883 Aug 16 16:30 john.csr
-rw------- 1 root root 1704 Aug 16 16:30 john.key
-rw-r--r-- 1 root root  318 Aug 16 16:26 use-pv.yaml

controlplane ~ ➜  vi john-csr.yaml

controlplane ~ ➜  openssl x509 -req -in /root/CKA/john.csr -CA /etc/kubernetes/pki/ca.crt -CAkey /etc/kubernetes/pki
/ca.key -CAcreateserial -out /root/CKA/john.crt -days 500
Certificate request self-signature ok
subject=CN = john

controlplane ~ ➜  vi john-usb.yaml

controlplane ~ ➜  vi john-csr.yaml

controlplane ~ ➜  kubectl create -f john-csr.yaml
clusterrole.rbac.authorization.k8s.io/john-developer created

controlplane ~ ➜  kubectl create -f john-usb.yaml
role.rbac.authorization.k8s.io/john-developer-role created

controlplane ~ ➜  kubectl config set-credentials john --client-certificate=/root/CKA/john.crt --client-key=/root/CKA/john.key
User "john" set.

controlplane ~ ➜  kubectl config set-context john-developer  --cluster=kubernetes --namespace=test-namespace --user=
john
Context "john-developer" created.

controlplane ~ ➜  kubectl get pods --all-namespaces
NAMESPACE     NAME                                   READY   STATUS    RESTARTS      AGE
default       nginx-deploy-58f87d49-bj6qh            1/1     Running   0             14m
default       redis-storage                          1/1     Running   0             31m
default       super-user-pod                         1/1     Running   0             28m
default       use-pv                                 0/1     Pending   0             17m
kube-system   coredns-768b85b76f-c6pr9               1/1     Running   0             57m
kube-system   coredns-768b85b76f-dsq2p               1/1     Running   0             57m
kube-system   etcd-controlplane                      1/1     Running   0             57m
kube-system   kube-apiserver-controlplane            1/1     Running   0             57m
kube-system   kube-controller-manager-controlplane   1/1     Running   0             57m
kube-system   kube-proxy-crxj6                       1/1     Running   0             56m
kube-system   kube-proxy-h8r6z                       1/1     Running   0             57m
kube-system   kube-scheduler-controlplane            1/1     Running   0             57m
kube-system   weave-net-pfdjt                        2/2     Running   0             56m
kube-system   weave-net-tlxn5                        2/2     Running   1 (57m ago)   57m

controlplane ~ ➜   kubectl expose deployment nginx-resolver --type=NodePort --port=8080 --name=nginx-resolver-service
Error from server (NotFound): deployments.apps "nginx-resolver" not found

controlplane ~ ✖ kubectl run nginx-resolver --image=nginx
pod/nginx-resolver created

controlplane ~ ➜  kubectl expose deployment nginx-resolver --type=NodePort --port=8080 --name=nginx-resolver-service
Error from server (NotFound): deployments.apps "nginx-resolver" not found

controlplane ~ ✖ kubectl run nginx-critical --image=nginx --dry-run=client -o yaml > nginx-critical.yaml

controlplane ~ ➜  vi nginx-critical.yaml

controlplane ~ ➜  mv  nginx-critical.yaml /etc/kubernetes/manifests

controlplane ~ ➜  ls -l /etc/kubernetes/manifests
total 20
-rw------- 1 root root 2406 Aug 16 15:46 etcd.yaml
-rw------- 1 root root 3882 Aug 16 15:46 kube-apiserver.yaml
-rw------- 1 root root 3393 Aug 16 15:46 kube-controller-manager.yaml
-rw------- 1 root root 1463 Aug 16 15:46 kube-scheduler.yaml
-rw-r--r-- 1 root root  278 Aug 16 16:49 nginx-critical.yaml

controlplane ~ ➜  kubectl get pods -o wide
NAME                          READY   STATUS    RESTARTS   AGE     IP             NODE           NOMINATED NODE   READINESS GATES
nginx-critical-controlplane   1/1     Running   0          16s     10.244.0.4     controlplane   <none>           <none>
nginx-deploy-58f87d49-bj6qh   1/1     Running   0          20m     10.244.192.4   node01         <none>           <none>
nginx-resolver                1/1     Running   0          2m48s   10.244.192.3   node01         <none>           <none>
redis-storage                 1/1     Running   0          37m     10.244.192.1   node01         <none>           <none>
super-user-pod                1/1     Running   0          34m     10.244.192.2   node01         <none>           <none>
use-pv                        0/1     Pending   0          23m     <none>         <none>         <none>           <none>

controlplane ~ ➜  kubectl get pods -o wide 



------


---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: my-pvc
spec:
  accessModes:
  - ReadWriteOnce
  resources:
    requests:
       storage: 10Mi


apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: use-pv
  name: use-pv
spec:
  containers:
  - image: nginx
    name: use-pv
    volumeMounts:
    - mountPath: "/data"
      name: mypd
  volumes:
    - name: mypd
      persistentVolumeClaim:
        claimName: my-pvc


Finally, create the pod by running:
kubectl create -f /root/CKA/use-pv.yaml

```bash
Solution
Solution manifest file to create a CSR as follows:

---
apiVersion: certificates.k8s.io/v1
kind: CertificateSigningRequest
metadata:
  name: john-developer
spec:
  signerName: kubernetes.io/kube-apiserver-client
  request: LS0tLS1CRUdJTiBDRVJUSUZJQ0FURSBSRVFVRVNULS0tLS0KTUlJQ1ZEQ0NBVHdDQVFBd0R6RU5NQXNHQTFVRUF3d0VhbTlvYmpDQ0FTSXdEUVlKS29aSWh2Y05BUUVCQlFBRApnZ0VQQURDQ0FRb0NnZ0VCQUt2Um1tQ0h2ZjBrTHNldlF3aWVKSzcrVVdRck04ZGtkdzkyYUJTdG1uUVNhMGFPCjV3c3cwbVZyNkNjcEJFRmVreHk5NUVydkgyTHhqQTNiSHVsTVVub2ZkUU9rbjYra1NNY2o3TzdWYlBld2k2OEIKa3JoM2prRFNuZGFvV1NPWXBKOFg1WUZ5c2ZvNUpxby82YU92czFGcEc3bm5SMG1JYWpySTlNVVFEdTVncGw4bgpjakY0TG4vQ3NEb3o3QXNadEgwcVpwc0dXYVpURTBKOWNrQmswZWhiV2tMeDJUK3pEYzlmaDVIMjZsSE4zbHM4CktiSlRuSnY3WDFsNndCeTN5WUFUSXRNclpUR28wZ2c1QS9uREZ4SXdHcXNlMTdLZDRaa1k3RDJIZ3R4UytkMEMKMTNBeHNVdzQyWVZ6ZzhkYXJzVGRMZzcxQ2NaanRxdS9YSmlyQmxVQ0F3RUFBYUFBTUEwR0NTcUdTSWIzRFFFQgpDd1VBQTRJQkFRQ1VKTnNMelBKczB2czlGTTVpUzJ0akMyaVYvdXptcmwxTGNUTStsbXpSODNsS09uL0NoMTZlClNLNHplRlFtbGF0c0hCOGZBU2ZhQnRaOUJ2UnVlMUZnbHk1b2VuTk5LaW9FMnc3TUx1a0oyODBWRWFxUjN2SSsKNzRiNnduNkhYclJsYVhaM25VMTFQVTlsT3RBSGxQeDNYVWpCVk5QaGhlUlBmR3p3TTRselZuQW5mNm96bEtxSgpvT3RORStlZ2FYWDdvc3BvZmdWZWVqc25Yd0RjZ05pSFFTbDgzSkljUCtjOVBHMDJtNyt0NmpJU3VoRllTVjZtCmlqblNucHBKZWhFUGxPMkFNcmJzU0VpaFB1N294Wm9iZDFtdWF4bWtVa0NoSzZLeGV0RjVEdWhRMi80NEMvSDIKOWk1bnpMMlRST3RndGRJZjAveUF5N05COHlOY3FPR0QKLS0tLS1FTkQgQ0VSVElGSUNBVEUgUkVRVUVTVC0tLS0tCg==
  usages:
  - digital signature
  - key encipherment
  - client auth

To approve this certificate, run: kubectl certificate approve john-developer

Next, create a role developer and rolebinding developer-role-binding, run the command:

$ kubectl create role developer --resource=pods --verb=create,list,get,update,delete --namespace=development

$ kubectl create rolebinding developer-role-binding --role=developer --user=john --namespace=development

To verify the permission from kubectl utility tool:

$ kubectl auth can-i update pods --as=john --namespace=development
```


```bash
Solution
Use the command kubectl run and create a nginx pod and busybox pod. Resolve it, nginx service and its pod name from busybox pod.

To create a pod nginx-resolver and expose it internally:

kubectl run nginx-resolver --image=nginx
kubectl expose pod nginx-resolver --name=nginx-resolver-service --port=80 --target-port=80 --type=ClusterIP

To create a pod test-nslookup. Test that you are able to look up the service and pod names from within the cluster:

kubectl run test-nslookup --image=busybox:1.28 --rm -it --restart=Never -- nslookup nginx-resolver-service
kubectl run test-nslookup --image=busybox:1.28 --rm -it --restart=Never -- nslookup nginx-resolver-service > /root/CKA/nginx.svc

Get the IP of the nginx-resolver pod and replace the dots(.) with hyphon(-) which will be used below.

kubectl get pod nginx-resolver -o wide
kubectl run test-nslookup --image=busybox:1.28 --rm -it --restart=Never -- nslookup <P-O-D-I-P.default.pod> > /root/CKA/nginx.pod
```


```bash
Solution
To create a static pod called nginx-critical by using below command:

kubectl run nginx-critical --image=nginx --dry-run=client -o yaml > static.yaml

Copy the contents of this file or use scp command to transfer this file from controlplane to node01 node.

root@controlplane:~# scp static.yaml node01:/root/

To know the IP Address of the node01 node:

root@controlplane:~# kubectl get nodes -o wide

# Perform SSH
root@controlplane:~# ssh node01
OR
root@controlplane:~# ssh <IP of node01>

On node01 node:

Check if static pod directory is present which is /etc/kubernetes/manifests, if it's not present then create it.

root@node01:~# mkdir -p /etc/kubernetes/manifests

Add that complete path to the staticPodPath field in the kubelet config.yaml file.

root@node01:~# vi /var/lib/kubelet/config.yaml

now, move/copy the static.yaml to path /etc/kubernetes/manifests/.

root@node01:~# cp /root/static.yaml /etc/kubernetes/manifests/

Go back to the controlplane node and check the status of static pod:

root@node01:~# exit
logout
root@controlplane:~# kubectl get pods 
```

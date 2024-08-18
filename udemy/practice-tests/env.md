       Welcome to the KodeKloud Hands-On lab                                                                         
    __ ______  ____  ________ __ __    ____  __  ______ 
   / //_/ __ \/ __ \/ ____/ //_// /   / __ \/ / / / __ \
  / ,< / / / / / / / __/ / ,<  / /   / / / / / / / / / /
 / /| / /_/ / /_/ / /___/ /| |/ /___/ /_/ / /_/ / /_/ / 
/_/ |_\____/_____/_____/_/ |_/_____/\____/\____/_____/  
                                                        
            All rights reserved                                                                                      

controlplane ~ ➜  kubectl get pods
NAME           READY   STATUS    RESTARTS   AGE
webapp-color   1/1     Running   0          3m49s

controlplane ~ ➜  kubectl get pods/webapp-color  -o json
{
    "apiVersion": "v1",
    "kind": "Pod",
    "metadata": {
        "creationTimestamp": "2024-08-15T21:35:11Z",
        "labels": {
            "name": "webapp-color"
        },
        "name": "webapp-color",
        "namespace": "default",
        "resourceVersion": "1060",
        "uid": "72e696f2-610c-4e5d-a33c-2419533bf221"
    },
    "spec": {
        "containers": [
            {
                "env": [
                    {
                        "name": "APP_COLOR",
                        "value": "pink"
                    }
                ],
                "image": "kodekloud/webapp-color",
                "imagePullPolicy": "Always",
                "name": "webapp-color",
                "resources": {},
                "terminationMessagePath": "/dev/termination-log",
                "terminationMessagePolicy": "File",
                "volumeMounts": [
                    {
                        "mountPath": "/var/run/secrets/kubernetes.io/serviceaccount",
                        "name": "kube-api-access-vn9mb",
                        "readOnly": true
                    }
                ]
            }
        ],
        "dnsPolicy": "ClusterFirst",
        "enableServiceLinks": true,
        "nodeName": "controlplane",
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
                "name": "kube-api-access-vn9mb",
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
                "lastTransitionTime": "2024-08-15T21:35:18Z",
                "status": "True",
                "type": "PodReadyToStartContainers"
            },
            {
                "lastProbeTime": null,
                "lastTransitionTime": "2024-08-15T21:35:11Z",
                "status": "True",
                "type": "Initialized"
            },
            {
                "lastProbeTime": null,
                "lastTransitionTime": "2024-08-15T21:35:18Z",
                "status": "True",
                "type": "Ready"
            },
            {
                "lastProbeTime": null,
                "lastTransitionTime": "2024-08-15T21:35:18Z",
                "status": "True",
                "type": "ContainersReady"
            },
            {
                "lastProbeTime": null,
                "lastTransitionTime": "2024-08-15T21:35:11Z",
                "status": "True",
                "type": "PodScheduled"
            }
        ],
        "containerStatuses": [
            {
                "containerID": "containerd://4eadb39f9c6770d9f4679cfdd13c14153e686567f7326a0e327b9043c3fa14b3",
                "image": "docker.io/kodekloud/webapp-color:latest",
                "imageID": "docker.io/kodekloud/webapp-color@sha256:99c3821ea49b89c7a22d3eebab5c2e1ec651452e7675af243485034a72eb1423",
                "lastState": {},
                "name": "webapp-color",
                "ready": true,
                "restartCount": 0,
                "started": true,
                "state": {
                    "running": {
                        "startedAt": "2024-08-15T21:35:17Z"
                    }
                }
            }
        ],
        "hostIP": "192.41.167.9",
        "hostIPs": [
            {
                "ip": "192.41.167.9"
            }
        ],
        "phase": "Running",
        "podIP": "10.42.0.9",
        "podIPs": [
            {
                "ip": "10.42.0.9"
            }
        ],
        "qosClass": "BestEffort",
        "startTime": "2024-08-15T21:35:11Z"
    }
}

controlplane ~ ➜  kubectl edit pods/webapp-color  -o json
error: pods "webapp-color" is invalid
A copy of your changes has been stored to "/tmp/kubectl-edit-593425293.json"
error: Edit cancelled, no valid changes were saved.

controlplane ~ ✖ kubectl get pods/webapp-color  -o json > webapp-color.json

controlplane ~ ➜  kubectl delete pods/webapp-color --force --grace-period=0
Warning: Immediate deletion does not wait for confirmation that the running resource has been terminated. The resource may continue to run on the cluster indefinitely.
pod "webapp-color" force deleted

controlplane ~ ➜  vi  webapp-color.json

controlplane ~ ➜  kubectl create -f webapp-color.json
pod/webapp-color created

controlplane ~ ➜  kubectl get configmap -o wide
NAME               DATA   AGE
kube-root-ca.crt   1      41m
db-config          3      15s

controlplane ~ ➜  kubectl get configmap/db-config  -o wide
NAME        DATA   AGE
db-config   3      37s

controlplane ~ ➜  kubectl describe  configmap/db-config 
Name:         db-config
Namespace:    default
Labels:       <none>
Annotations:  <none>

Data
====
DB_NAME:
----
SQL01
DB_PORT:
----
3306
DB_HOST:
----
SQL01.example.com

BinaryData
====

Events:  <none>

controlplane ~ ➜  kubectl get configmap/db-config  -o yaml > webapp-config-map.yaml

controlplane ~ ➜  vi webapp-config-map.yaml

controlplane ~ ➜  kubectl create -f webapp-config-map.yaml
configmap/webapp-config-map created

controlplane ~ ➜  kubectl edit pod/webapp-color
error: pods "webapp-color" is invalid
A copy of your changes has been stored to "/tmp/kubectl-edit-4101506984.yaml"
error: Edit cancelled, no valid changes were saved.

controlplane ~ ✖ kubectl get  pod/webapp-color -o yaml > webapp-color.yaml

controlplane ~ ➜  kubectl delete pod/webapp-color --force --grace-period=0
Warning: Immediate deletion does not wait for confirmation that the running resource has been terminated. The resource may continue to run on the cluster indefinitely.
pod "webapp-color" force deleted

controlplane ~ ➜  vi webapp-color.yaml

controlplane ~ ➜  kubectl create -f webapp-color.yaml
Error from server (BadRequest): error when creating "webapp-color.yaml": Pod in version "v1" cannot be handled as a Pod: json: cannot unmarshal string into Go struct field EnvFromSource.spec.containers.envFrom.configMapRef of type v1.ConfigMapEnvSource

controlplane ~ ✖ vi webapp-color.yaml

controlplane ~ ➜  kubectl create -f webapp-color.yaml
pod/webapp-color created

controlplane ~ ➜  kubectl describe pod/webapp-color
Name:             webapp-color
Namespace:        default
Priority:         0
Service Account:  default
Node:             controlplane/192.41.167.9
Start Time:       Thu, 15 Aug 2024 22:02:55 +0000
Labels:           name=webapp-color
Annotations:      <none>
Status:           Running
IP:               10.42.0.11
IPs:
  IP:  10.42.0.11
Containers:
  webapp-color:
    Container ID:   containerd://79fc79cb88a924d0074208d2bfd2e6fa7df81370f54cd267a767122370d0fc58
    Image:          kodekloud/webapp-color
    Image ID:       docker.io/kodekloud/webapp-color@sha256:99c3821ea49b89c7a22d3eebab5c2e1ec651452e7675af243485034a72eb1423
    Port:           <none>
    Host Port:      <none>
    State:          Running
      Started:      Thu, 15 Aug 2024 22:02:56 +0000
    Ready:          True
    Restart Count:  0
    Environment Variables from:
      webapp-config-map  ConfigMap  Optional: false
    Environment:         <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-vn9mb (ro)
Conditions:
  Type                        Status
  PodReadyToStartContainers   True 
  Initialized                 True 
  Ready                       True 
  ContainersReady             True 
  PodScheduled                True 
Volumes:
  kube-api-access-vn9mb:
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
  Type    Reason   Age   From     Message
  ----    ------   ----  ----     -------
  Normal  Pulling  2m3s  kubelet  Pulling image "kodekloud/webapp-color"
  Normal  Pulled   2m3s  kubelet  Successfully pulled image "kodekloud/webapp-color" in 154ms (154ms including waiting). Image size: 31777918 bytes.
  Normal  Created  2m3s  kubelet  Created container webapp-color
  Normal  Started  2m3s  kubelet  Started container webapp-color

controlplane ~ ➜  

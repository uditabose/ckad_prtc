       Welcome to the KodeKloud Hands-On lab                                                                         
    __ ______  ____  ________ __ __    ____  __  ______ 
   / //_/ __ \/ __ \/ ____/ //_// /   / __ \/ / / / __ \
  / ,< / / / / / / / __/ / ,<  / /   / / / / / / / / / /
 / /| / /_/ / /_/ / /___/ /| |/ /___/ /_/ / /_/ / /_/ / 
/_/ |_\____/_____/_____/_/ |_/_____/\____/\____/_____/  
                                                        
            All rights reserved                                                                                      

controlplane ~ ➜  kubectl run nginx-pod --image=nginx:alpine
pod/nginx-pod created

controlplane ~ ➜  kubectl get pod/nginx-pod -o wide
NAME        READY   STATUS    RESTARTS   AGE   IP           NODE           NOMINATED NODE   READINESS GATES
nginx-pod   1/1     Running   0          13s   10.244.0.4   controlplane   <none>           <none>

controlplane ~ ➜  kubectl run messaging --image=redis:alpine --labels=tier=msg
pod/messaging created

controlplane ~ ➜  kubectl get pod/messaging -o wide --show-labels
NAME        READY   STATUS    RESTARTS   AGE   IP           NODE           NOMINATED NODE   READINESS GATES   LABELS
messaging   1/1     Running   0          19s   10.244.0.5   controlplane   <none>           <none>            tier=msg

controlplane ~ ➜  kubectl create namespace apx-x9984574
namespace/apx-x9984574 created

controlplane ~ ➜  kubectl get namespaces -o wide
NAME              STATUS   AGE
apx-x9984574      Active   11s
default           Active   46m
kube-flannel      Active   46m
kube-node-lease   Active   46m
kube-public       Active   46m
kube-system       Active   46m

controlplane ~ ➜  kubectl get nodes -o json
{
    "apiVersion": "v1",
    "items": [
        {
            "apiVersion": "v1",
            "kind": "Node",
            "metadata": {
                "annotations": {
                    "flannel.alpha.coreos.com/backend-data": "{\"VNI\":1,\"VtepMAC\":\"46:c1:c4:b7:8a:1f\"}",
                    "flannel.alpha.coreos.com/backend-type": "vxlan",
                    "flannel.alpha.coreos.com/kube-subnet-manager": "true",
                    "flannel.alpha.coreos.com/public-ip": "192.28.219.6",
                    "kubeadm.alpha.kubernetes.io/cri-socket": "unix:///var/run/containerd/containerd.sock",
                    "node.alpha.kubernetes.io/ttl": "0",
                    "volumes.kubernetes.io/controller-managed-attach-detach": "true"
                },
                "creationTimestamp": "2024-08-16T13:18:50Z",
                "labels": {
                    "beta.kubernetes.io/arch": "amd64",
                    "beta.kubernetes.io/os": "linux",
                    "kubernetes.io/arch": "amd64",
                    "kubernetes.io/hostname": "controlplane",
                    "kubernetes.io/os": "linux",
                    "node-role.kubernetes.io/control-plane": "",
                    "node.kubernetes.io/exclude-from-external-load-balancers": ""
                },
                "name": "controlplane",
                "resourceVersion": "4057",
                "uid": "3846be28-c02e-47fb-9b7e-14f3ae967a5b"
            },
            "spec": {
                "podCIDR": "10.244.0.0/24",
                "podCIDRs": [
                    "10.244.0.0/24"
                ]
            },
            "status": {
                "addresses": [
                    {
                        "address": "192.28.219.6",
                        "type": "InternalIP"
                    },
                    {
                        "address": "controlplane",
                        "type": "Hostname"
                    }
                ],
                "allocatable": {
                    "cpu": "36",
                    "ephemeral-storage": "936398358207",
                    "hugepages-1Gi": "0",
                    "hugepages-2Mi": "0",
                    "memory": "214484648Ki",
                    "pods": "110"
                },
                "capacity": {
                    "cpu": "36",
                    "ephemeral-storage": "1016057248Ki",
                    "hugepages-1Gi": "0",
                    "hugepages-2Mi": "0",
                    "memory": "214587048Ki",
                    "pods": "110"
                },
                "conditions": [
                    {
                        "lastHeartbeatTime": "2024-08-16T13:19:16Z",
                        "lastTransitionTime": "2024-08-16T13:19:16Z",
                        "message": "Flannel is running on this node",
                        "reason": "FlannelIsUp",
                        "status": "False",
                        "type": "NetworkUnavailable"
                    },
                    {
                        "lastHeartbeatTime": "2024-08-16T14:04:59Z",
                        "lastTransitionTime": "2024-08-16T13:18:45Z",
                        "message": "kubelet has sufficient memory available",
                        "reason": "KubeletHasSufficientMemory",
                        "status": "False",
                        "type": "MemoryPressure"
                    },
                    {
                        "lastHeartbeatTime": "2024-08-16T14:04:59Z",
                        "lastTransitionTime": "2024-08-16T13:18:45Z",
                        "message": "kubelet has no disk pressure",
                        "reason": "KubeletHasNoDiskPressure",
                        "status": "False",
                        "type": "DiskPressure"
                    },
                    {
                        "lastHeartbeatTime": "2024-08-16T14:04:59Z",
                        "lastTransitionTime": "2024-08-16T13:18:45Z",
                        "message": "kubelet has sufficient PID available",
                        "reason": "KubeletHasSufficientPID",
                        "status": "False",
                        "type": "PIDPressure"
                    },
                    {
                        "lastHeartbeatTime": "2024-08-16T14:04:59Z",
                        "lastTransitionTime": "2024-08-16T13:19:13Z",
                        "message": "kubelet is posting ready status",
                        "reason": "KubeletReady",
                        "status": "True",
                        "type": "Ready"
                    }
                ],
                "daemonEndpoints": {
                    "kubeletEndpoint": {
                        "Port": 10250
                    }
                },
                "images": [
                    {
                        "names": [
                            "docker.io/kodekloud/fluent-ui-running@sha256:78fd68ba8a79adcd3e58897a933492886200be513076ba37f843008cc0168f81",
                            "docker.io/kodekloud/fluent-ui-running:latest"
                        ],
                        "sizeBytes": 389734636
                    },
                    {
                        "names": [
                            "docker.io/library/nginx@sha256:ca4d9ee52958dd86eae2bcf2afc7ab95a772897c214ecce11b6e50a8aea98d06",
                            "docker.io/library/nginx:latest"
                        ],
                        "sizeBytes": 70984068
                    },
                    {
                        "names": [
                            "registry.k8s.io/etcd@sha256:44a8e24dcbba3470ee1fee21d5e88d128c936e9b55d4bc51fbef8086f8ed123b",
                            "registry.k8s.io/etcd:3.5.12-0"
                        ],
                        "sizeBytes": 57236178
                    },
                    {
                        "names": [
                            "registry.k8s.io/kube-apiserver@sha256:6b8e197b2d39c321189a475ac755a77896e34b56729425590fbc99f3a96468a3",
                            "registry.k8s.io/kube-apiserver:v1.30.0"
                        ],
                        "sizeBytes": 32663599
                    },
                    {
                        "names": [
                            "registry.k8s.io/kube-controller-manager@sha256:5f52f00f17d5784b5ca004dffca59710fa1a9eec8d54cebdf9433a1d134150fe",
                            "registry.k8s.io/kube-controller-manager:v1.30.0"
                        ],
                        "sizeBytes": 31030110
                    },
                    {
                        "names": [
                            "docker.io/weaveworks/weave-kube@sha256:d797338e7beb17222e10757b71400d8471bdbd9be13b5da38ce2ebf597fb4e63",
                            "docker.io/weaveworks/weave-kube:2.8.1"
                        ],
                        "sizeBytes": 30924173
                    },
                    {
                        "names": [
                            "registry.k8s.io/kube-proxy@sha256:ec532ff47eaf39822387e51ec73f1f2502eb74658c6303319db88d2c380d0210",
                            "registry.k8s.io/kube-proxy:v1.30.0"
                        ],
                        "sizeBytes": 29020473
                    },
                    {
                        "names": [
                            "docker.io/flannel/flannel@sha256:c951947891d7811a4da6bf6f2f4dcd09e33c6e1eb6a95022f3f621d00ed4615e",
                            "docker.io/flannel/flannel:v0.23.0"
                        ],
                        "sizeBytes": 28051548
                    },
                    {
                        "names": [
                            "registry.k8s.io/kube-scheduler@sha256:2353c3a1803229970fcb571cffc9b2f120372350e01c7381b4b650c4a02b9d67",
                            "registry.k8s.io/kube-scheduler:v1.30.0"
                        ],
                        "sizeBytes": 19208660
                    },
                    {
                        "names": [
                            "docker.io/library/nginx@sha256:1e67a3c8607fe555f47dc8a72f25424b10273639136c061c508628da3112f90e",
                            "docker.io/library/nginx:alpine"
                        ],
                        "sizeBytes": 18405128
                    },
                    {
                        "names": [
                            "registry.k8s.io/coredns/coredns@sha256:1eeb4c7316bacb1d4c8ead65571cd92dd21e27359f0d4917f1a5822a73b75db1",
                            "registry.k8s.io/coredns/coredns:v1.11.1"
                        ],
                        "sizeBytes": 18182961
                    },
                    {
                        "names": [
                            "docker.io/library/redis@sha256:eaea8264f74a95ea9a0767c794da50788cbd9cf5223951674d491fa1b3f4f2d2",
                            "docker.io/library/redis:alpine"
                        ],
                        "sizeBytes": 17173585
                    },
                    {
                        "names": [
                            "registry.k8s.io/coredns/coredns@sha256:a0ead06651cf580044aeb0a0feba63591858fb2e43ade8c9dea45a6a89ae7e5e",
                            "registry.k8s.io/coredns/coredns:v1.10.1"
                        ],
                        "sizeBytes": 16190758
                    },
                    {
                        "names": [
                            "docker.io/weaveworks/weave-npc@sha256:38d3e30a97a2260558f8deb0fc4c079442f7347f27c86660dbfc8ca91674f14c",
                            "docker.io/weaveworks/weave-npc:2.8.1"
                        ],
                        "sizeBytes": 12814131
                    },
                    {
                        "names": [
                            "docker.io/flannel/flannel-cni-plugin@sha256:ca6779c6ad63b77af8a00151cefc08578241197b9a6fe144b0e55484bc52b852",
                            "docker.io/flannel/flannel-cni-plugin:v1.2.0"
                        ],
                        "sizeBytes": 3879095
                    },
                    {
                        "names": [
                            "docker.io/library/busybox@sha256:9ae97d36d26566ff84e8893c64a6dc4fe8ca6d1144bf5b87b2b85a32def253c7",
                            "docker.io/library/busybox:latest"
                        ],
                        "sizeBytes": 2160406
                    },
                    {
                        "names": [
                            "registry.k8s.io/pause@sha256:7031c1b283388d2c2e09b57badb803c05ebed362dc88d84b480cc47f72a21097",
                            "registry.k8s.io/pause:3.9"
                        ],
                        "sizeBytes": 321520
                    },
                    {
                        "names": [
                            "registry.k8s.io/pause@sha256:3d380ca8864549e74af4b29c10f9cb0956236dfb01c40ca076fb6c37253234db",
                            "registry.k8s.io/pause:3.6"
                        ],
                        "sizeBytes": 301773
                    }
                ],
                "nodeInfo": {
                    "architecture": "amd64",
                    "bootID": "feb9c0fd-0147-4ea3-9ed8-90046e04ad6d",
                    "containerRuntimeVersion": "containerd://1.6.26",
                    "kernelVersion": "5.4.0-1106-gcp",
                    "kubeProxyVersion": "v1.30.0",
                    "kubeletVersion": "v1.30.0",
                    "machineID": "2e42ca3b57184b5f966a8ae586de128a",
                    "operatingSystem": "linux",
                    "osImage": "Ubuntu 22.04.4 LTS",
                    "systemUUID": "1c118f50-8f55-130d-4ecb-6247a1344870"
                }
            }
        }
    ],
    "kind": "List",
    "metadata": {
        "resourceVersion": ""
    }
}

controlplane ~ ➜  kubectl get nodes -o json > /opt/outputs/nodes-z3444kd9.json

controlplane ~ ➜  kubectl create service clusterip messaging-service --tcp=6579:6379
service/messaging-service created

controlplane ~ ➜  kubectl create deployment hr-web-app --image=kodekloud/webapp-color
deployment.apps/hr-web-app created

controlplane ~ ➜  kubectl edit deployment.apps/hr-web-app
deployment.apps/hr-web-app edited

controlplane ~ ➜  ls -l /etc/kubernetes/
total 44
-rw------- 1 root root 5656 Aug 16 13:18 admin.conf
-rw------- 1 root root 5676 Aug 16 13:18 controller-manager.conf
-rw------- 1 root root 1992 Aug 16 13:18 kubelet.conf
drwxrwxr-x 1 root root 4096 Aug 16 13:18 manifests
drwxr-xr-x 3 root root 4096 Aug 16 13:18 pki
-rw------- 1 root root 5624 Aug 16 13:18 scheduler.conf
-rw------- 1 root root 5680 Aug 16 13:18 super-admin.conf

controlplane ~ ➜  ls -l /etc/kubernetes/manifests/
total 16
-rw------- 1 root root 2406 Aug 16 13:18 etcd.yaml
-rw------- 1 root root 3882 Aug 16 13:18 kube-apiserver.yaml
-rw------- 1 root root 3393 Aug 16 13:18 kube-controller-manager.yaml
-rw------- 1 root root 1463 Aug 16 13:18 kube-scheduler.yaml

controlplane ~ ➜  vi /etc/kubernetes/manifests/static-busybox.yaml

controlplane ~ ➜  kubectl get pods --all-namespaces
NAMESPACE      NAME                                   READY   STATUS              RESTARTS   AGE
default        hr-web-app-5d6b77db78-756j9            1/1     Running             0          2m54s
default        hr-web-app-5d6b77db78-khq2p            1/1     Running             0          3m15s
default        messaging                              1/1     Running             0          7m40s
default        nginx-pod                              1/1     Running             0          8m42s
default        static-busybox-controlplane            0/1     ContainerCreating   0          15s
kube-flannel   kube-flannel-ds-jwx5p                  1/1     Running             0          53m
kube-system    coredns-768b85b76f-5zcpw               1/1     Running             0          53m
kube-system    coredns-768b85b76f-hczd5               1/1     Running             0          53m
kube-system    etcd-controlplane                      1/1     Running             0          53m
kube-system    kube-apiserver-controlplane            1/1     Running             0          53m
kube-system    kube-controller-manager-controlplane   1/1     Running             0          53m
kube-system    kube-proxy-4kf69                       1/1     Running             0          53m
kube-system    kube-scheduler-controlplane            1/1     Running             0          53m

controlplane ~ ➜  kubectl get namespace temp-bus
Error from server (NotFound): namespaces "temp-bus" not found

controlplane ~ ✖ kubectl get namespaces
NAME              STATUS   AGE
apx-x9984574      Active   7m42s
default           Active   54m
finance           Active   31s
kube-flannel      Active   54m
kube-node-lease   Active   54m
kube-public       Active   54m
kube-system       Active   54m

controlplane ~ ➜  kubectl create namespace temp-bus
namespace/temp-bus created

controlplane ~ ➜  kubectl create namespace finance
Error from server (AlreadyExists): namespaces "finance" already exists

controlplane ~ ✖ kubectl run temp-bus --image=redis:alpine --namespace=finance
pod/temp-bus created

controlplane ~ ➜  kubectl get pod/temp-bus
Error from server (NotFound): pods "temp-bus" not found

controlplane ~ ✖ kubectl get pod/temp-bus --namespace=finance
NAME       READY   STATUS    RESTARTS   AGE
temp-bus   1/1     Running   0          14s

controlplane ~ ➜  kubectl get deployments orange
Error from server (NotFound): deployments.apps "orange" not found

controlplane ~ ✖ kubectl get pod orange
NAME     READY   STATUS       RESTARTS      AGE
orange   0/1     Init:Error   2 (22s ago)   25s

controlplane ~ ➜  kubectl describe pod orange
Name:             orange
Namespace:        default
Priority:         0
Service Account:  default
Node:             controlplane/192.28.219.6
Start Time:       Fri, 16 Aug 2024 14:14:32 +0000
Labels:           <none>
Annotations:      <none>
Status:           Pending
IP:               10.244.0.10
IPs:
  IP:  10.244.0.10
Init Containers:
  init-myservice:
    Container ID:  containerd://7e7bbf50fb9b03747072a45d254e1f0028dab6a6e1f295d7e60dc54d1067a84c
    Image:         busybox
    Image ID:      docker.io/library/busybox@sha256:9ae97d36d26566ff84e8893c64a6dc4fe8ca6d1144bf5b87b2b85a32def253c7
    Port:          <none>
    Host Port:     <none>
    Command:
      sh
      -c
      sleeeep 2;
    State:          Waiting
      Reason:       CrashLoopBackOff
    Last State:     Terminated
      Reason:       Error
      Exit Code:    127
      Started:      Fri, 16 Aug 2024 14:14:51 +0000
      Finished:     Fri, 16 Aug 2024 14:14:51 +0000
    Ready:          False
    Restart Count:  2
    Environment:    <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-2792f (ro)
Containers:
  orange-container:
    Container ID:  
    Image:         busybox:1.28
    Image ID:      
    Port:          <none>
    Host Port:     <none>
    Command:
      sh
      -c
      echo The app is running! && sleep 3600
    State:          Waiting
      Reason:       PodInitializing
    Ready:          False
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-2792f (ro)
Conditions:
  Type                        Status
  PodReadyToStartContainers   True 
  Initialized                 False 
  Ready                       False 
  ContainersReady             False 
  PodScheduled                True 
Volumes:
  kube-api-access-2792f:
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
  Type     Reason     Age                From               Message
  ----     ------     ----               ----               -------
  Normal   Scheduled  41s                default-scheduler  Successfully assigned default/orange to controlplane
  Normal   Pulled     40s                kubelet            Successfully pulled image "busybox" in 170ms (170ms including waiting). Image size: 2160406 bytes.
  Normal   Pulled     39s                kubelet            Successfully pulled image "busybox" in 164ms (164ms including waiting). Image size: 2160406 bytes.
  Normal   Pulling    23s (x3 over 40s)  kubelet            Pulling image "busybox"
  Normal   Pulled     23s                kubelet            Successfully pulled image "busybox" in 200ms (200ms including waiting). Image size: 2160406 bytes.
  Normal   Created    22s (x3 over 40s)  kubelet            Created container init-myservice
  Normal   Started    22s (x3 over 40s)  kubelet            Started container init-myservice
  Warning  BackOff    10s (x4 over 38s)  kubelet            Back-off restarting failed container init-myservice in pod orange_default(aa371fbe-1c29-4c26-84e1-daebdc095be6)

controlplane ~ ➜  kubectl edit pod orange
error: pods "orange" is invalid
A copy of your changes has been stored to "/tmp/kubectl-edit-563079109.yaml"
error: Edit cancelled, no valid changes were saved.

controlplane ~ ✖ kubectl delete pod orange --force --grace-period=0
Warning: Immediate deletion does not wait for confirmation that the running resource has been terminated. The resource may continue to run on the cluster indefinitely.
pod "orange" force deleted

controlplane ~ ➜  kubectl create -f /tmp/kubectl-edit-563079109.yaml
pod/orange created

controlplane ~ ➜  kubectl describe pod orange
Name:             orange
Namespace:        default
Priority:         0
Service Account:  default
Node:             controlplane/192.28.219.6
Start Time:       Fri, 16 Aug 2024 14:16:48 +0000
Labels:           <none>
Annotations:      <none>
Status:           Running
IP:               10.244.0.11
IPs:
  IP:  10.244.0.11
Init Containers:
  init-myservice:
    Container ID:  containerd://f6ea3d71e0a2ec17f1728029ee41d948b903e34707c277f7ce2d33f6dbb4e08d
    Image:         busybox
    Image ID:      docker.io/library/busybox@sha256:9ae97d36d26566ff84e8893c64a6dc4fe8ca6d1144bf5b87b2b85a32def253c7
    Port:          <none>
    Host Port:     <none>
    Command:
      sh
      -c
      sleep 2;
    State:          Terminated
      Reason:       Completed
      Exit Code:    0
      Started:      Fri, 16 Aug 2024 14:16:49 +0000
      Finished:     Fri, 16 Aug 2024 14:16:51 +0000
    Ready:          True
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-2792f (ro)
Containers:
  orange-container:
    Container ID:  containerd://ac48f2aa00cff10188f4711ac40b18da1c7e8fbe3bda5216794f2f9d9e9e0203
    Image:         busybox:1.28
    Image ID:      docker.io/library/busybox@sha256:141c253bc4c3fd0a201d32dc1f493bcf3fff003b6df416dea4f41046e0f37d47
    Port:          <none>
    Host Port:     <none>
    Command:
      sh
      -c
      echo The app is running! && sleep 3600
    State:          Running
      Started:      Fri, 16 Aug 2024 14:16:52 +0000
    Ready:          True
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-2792f (ro)
Conditions:
  Type                        Status
  PodReadyToStartContainers   True 
  Initialized                 True 
  Ready                       True 
  ContainersReady             True 
  PodScheduled                True 
Volumes:
  kube-api-access-2792f:
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
  Normal  Pulling  4s    kubelet  Pulling image "busybox"
  Normal  Pulled   4s    kubelet  Successfully pulled image "busybox" in 163ms (163ms including waiting). Image size: 2160406 bytes.
  Normal  Created  4s    kubelet  Created container init-myservice
  Normal  Started  4s    kubelet  Started container init-myservice
  Normal  Pulling  1s    kubelet  Pulling image "busybox:1.28"
  Normal  Pulled   1s    kubelet  Successfully pulled image "busybox:1.28" in 292ms (292ms including waiting). Image size: 727869 bytes.
  Normal  Created  1s    kubelet  Created container orange-container
  Normal  Started  1s    kubelet  Started container orange-container

controlplane ~ ➜  kubectl get pod orange -o wide
NAME     READY   STATUS    RESTARTS   AGE   IP            NODE           NOMINATED NODE   READINESS GATES
orange   1/1     Running   0          26s   10.244.0.11   controlplane   <none>           <none>

controlplane ~ ➜    kubectl create service nodeport hr-web-app-service --tcp=8080:6379 --dry-run=client --dry-run -o yaml > hr-web-app-service.yaml
W0816 14:24:47.839730   32748 helpers.go:703] --dry-run is deprecated and can be replaced with --dry-run=client.

controlplane ~ ➜  kubectl create service nodeport hr-web-app-service --tcp=8080:6379 --dry-run=client --dry-run=client -o yaml > hr-web-app-service.yaml

controlplane ~ ➜  vi hr-web-app-service.yaml

controlplane ~ ➜  kubectl create -f hr-web-app-service.yaml
service/hr-web-app-service created

controlplane ~ ➜  kubectl get services -o wide
NAME                 TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)          AGE   SELECTOR
hr-web-app-service   NodePort    10.101.209.110   <none>        8080:30082/TCP   12s   app=hr-web-app-service
kubernetes           ClusterIP   10.96.0.1        <none>        443/TCP          67m   <none>
messaging-service    ClusterIP   10.108.68.164    <none>        6579/TCP         17m   app=messaging-service

controlplane ~ ➜  kubectl get nodes
NAME           STATUS   ROLES           AGE   VERSION
controlplane   Ready    control-plane   68m   v1.30.0

controlplane ~ ➜  kubectl get nodes --all-namespaces
NAME           STATUS   ROLES           AGE   VERSION
controlplane   Ready    control-plane   68m   v1.30.0

controlplane ~ ➜  kubectl get node controlplane -o json
{
    "apiVersion": "v1",
    "kind": "Node",
    "metadata": {
        "annotations": {
            "flannel.alpha.coreos.com/backend-data": "{\"VNI\":1,\"VtepMAC\":\"46:c1:c4:b7:8a:1f\"}",
            "flannel.alpha.coreos.com/backend-type": "vxlan",
            "flannel.alpha.coreos.com/kube-subnet-manager": "true",
            "flannel.alpha.coreos.com/public-ip": "192.28.219.6",
            "kubeadm.alpha.kubernetes.io/cri-socket": "unix:///var/run/containerd/containerd.sock",
            "node.alpha.kubernetes.io/ttl": "0",
            "volumes.kubernetes.io/controller-managed-attach-detach": "true"
        },
        "creationTimestamp": "2024-08-16T13:18:50Z",
        "labels": {
            "beta.kubernetes.io/arch": "amd64",
            "beta.kubernetes.io/os": "linux",
            "kubernetes.io/arch": "amd64",
            "kubernetes.io/hostname": "controlplane",
            "kubernetes.io/os": "linux",
            "node-role.kubernetes.io/control-plane": "",
            "node.kubernetes.io/exclude-from-external-load-balancers": ""
        },
        "name": "controlplane",
        "resourceVersion": "5912",
        "uid": "3846be28-c02e-47fb-9b7e-14f3ae967a5b"
    },
    "spec": {
        "podCIDR": "10.244.0.0/24",
        "podCIDRs": [
            "10.244.0.0/24"
        ]
    },
    "status": {
        "addresses": [
            {
                "address": "192.28.219.6",
                "type": "InternalIP"
            },
            {
                "address": "controlplane",
                "type": "Hostname"
            }
        ],
        "allocatable": {
            "cpu": "36",
            "ephemeral-storage": "936398358207",
            "hugepages-1Gi": "0",
            "hugepages-2Mi": "0",
            "memory": "214484648Ki",
            "pods": "110"
        },
        "capacity": {
            "cpu": "36",
            "ephemeral-storage": "1016057248Ki",
            "hugepages-1Gi": "0",
            "hugepages-2Mi": "0",
            "memory": "214587048Ki",
            "pods": "110"
        },
        "conditions": [
            {
                "lastHeartbeatTime": "2024-08-16T13:19:16Z",
                "lastTransitionTime": "2024-08-16T13:19:16Z",
                "message": "Flannel is running on this node",
                "reason": "FlannelIsUp",
                "status": "False",
                "type": "NetworkUnavailable"
            },
            {
                "lastHeartbeatTime": "2024-08-16T14:27:08Z",
                "lastTransitionTime": "2024-08-16T13:18:45Z",
                "message": "kubelet has sufficient memory available",
                "reason": "KubeletHasSufficientMemory",
                "status": "False",
                "type": "MemoryPressure"
            },
            {
                "lastHeartbeatTime": "2024-08-16T14:27:08Z",
                "lastTransitionTime": "2024-08-16T13:18:45Z",
                "message": "kubelet has no disk pressure",
                "reason": "KubeletHasNoDiskPressure",
                "status": "False",
                "type": "DiskPressure"
            },
            {
                "lastHeartbeatTime": "2024-08-16T14:27:08Z",
                "lastTransitionTime": "2024-08-16T13:18:45Z",
                "message": "kubelet has sufficient PID available",
                "reason": "KubeletHasSufficientPID",
                "status": "False",
                "type": "PIDPressure"
            },
            {
                "lastHeartbeatTime": "2024-08-16T14:27:08Z",
                "lastTransitionTime": "2024-08-16T13:19:13Z",
                "message": "kubelet is posting ready status",
                "reason": "KubeletReady",
                "status": "True",
                "type": "Ready"
            }
        ],
        "daemonEndpoints": {
            "kubeletEndpoint": {
                "Port": 10250
            }
        },
        "images": [
            {
                "names": [
                    "docker.io/kodekloud/fluent-ui-running@sha256:78fd68ba8a79adcd3e58897a933492886200be513076ba37f843008cc0168f81",
                    "docker.io/kodekloud/fluent-ui-running:latest"
                ],
                "sizeBytes": 389734636
            },
            {
                "names": [
                    "docker.io/library/nginx@sha256:ca4d9ee52958dd86eae2bcf2afc7ab95a772897c214ecce11b6e50a8aea98d06",
                    "docker.io/library/nginx:latest"
                ],
                "sizeBytes": 70984068
            },
            {
                "names": [
                    "registry.k8s.io/etcd@sha256:44a8e24dcbba3470ee1fee21d5e88d128c936e9b55d4bc51fbef8086f8ed123b",
                    "registry.k8s.io/etcd:3.5.12-0"
                ],
                "sizeBytes": 57236178
            },
            {
                "names": [
                    "registry.k8s.io/kube-apiserver@sha256:6b8e197b2d39c321189a475ac755a77896e34b56729425590fbc99f3a96468a3",
                    "registry.k8s.io/kube-apiserver:v1.30.0"
                ],
                "sizeBytes": 32663599
            },
            {
                "names": [
                    "docker.io/kodekloud/webapp-color@sha256:99c3821ea49b89c7a22d3eebab5c2e1ec651452e7675af243485034a72eb1423",
                    "docker.io/kodekloud/webapp-color:latest"
                ],
                "sizeBytes": 31777918
            },
            {
                "names": [
                    "registry.k8s.io/kube-controller-manager@sha256:5f52f00f17d5784b5ca004dffca59710fa1a9eec8d54cebdf9433a1d134150fe",
                    "registry.k8s.io/kube-controller-manager:v1.30.0"
                ],
                "sizeBytes": 31030110
            },
            {
                "names": [
                    "docker.io/weaveworks/weave-kube@sha256:d797338e7beb17222e10757b71400d8471bdbd9be13b5da38ce2ebf597fb4e63",
                    "docker.io/weaveworks/weave-kube:2.8.1"
                ],
                "sizeBytes": 30924173
            },
            {
                "names": [
                    "registry.k8s.io/kube-proxy@sha256:ec532ff47eaf39822387e51ec73f1f2502eb74658c6303319db88d2c380d0210",
                    "registry.k8s.io/kube-proxy:v1.30.0"
                ],
                "sizeBytes": 29020473
            },
            {
                "names": [
                    "docker.io/flannel/flannel@sha256:c951947891d7811a4da6bf6f2f4dcd09e33c6e1eb6a95022f3f621d00ed4615e",
                    "docker.io/flannel/flannel:v0.23.0"
                ],
                "sizeBytes": 28051548
            },
            {
                "names": [
                    "registry.k8s.io/kube-scheduler@sha256:2353c3a1803229970fcb571cffc9b2f120372350e01c7381b4b650c4a02b9d67",
                    "registry.k8s.io/kube-scheduler:v1.30.0"
                ],
                "sizeBytes": 19208660
            },
            {
                "names": [
                    "docker.io/library/nginx@sha256:1e67a3c8607fe555f47dc8a72f25424b10273639136c061c508628da3112f90e",
                    "docker.io/library/nginx:alpine"
                ],
                "sizeBytes": 18405128
            },
            {
                "names": [
                    "registry.k8s.io/coredns/coredns@sha256:1eeb4c7316bacb1d4c8ead65571cd92dd21e27359f0d4917f1a5822a73b75db1",
                    "registry.k8s.io/coredns/coredns:v1.11.1"
                ],
                "sizeBytes": 18182961
            },
            {
                "names": [
                    "docker.io/library/redis@sha256:eaea8264f74a95ea9a0767c794da50788cbd9cf5223951674d491fa1b3f4f2d2",
                    "docker.io/library/redis:alpine"
                ],
                "sizeBytes": 17173585
            },
            {
                "names": [
                    "registry.k8s.io/coredns/coredns@sha256:a0ead06651cf580044aeb0a0feba63591858fb2e43ade8c9dea45a6a89ae7e5e",
                    "registry.k8s.io/coredns/coredns:v1.10.1"
                ],
                "sizeBytes": 16190758
            },
            {
                "names": [
                    "docker.io/weaveworks/weave-npc@sha256:38d3e30a97a2260558f8deb0fc4c079442f7347f27c86660dbfc8ca91674f14c",
                    "docker.io/weaveworks/weave-npc:2.8.1"
                ],
                "sizeBytes": 12814131
            },
            {
                "names": [
                    "docker.io/flannel/flannel-cni-plugin@sha256:ca6779c6ad63b77af8a00151cefc08578241197b9a6fe144b0e55484bc52b852",
                    "docker.io/flannel/flannel-cni-plugin:v1.2.0"
                ],
                "sizeBytes": 3879095
            },
            {
                "names": [
                    "docker.io/library/busybox@sha256:9ae97d36d26566ff84e8893c64a6dc4fe8ca6d1144bf5b87b2b85a32def253c7",
                    "docker.io/library/busybox:latest"
                ],
                "sizeBytes": 2160406
            },
            {
                "names": [
                    "docker.io/library/busybox@sha256:141c253bc4c3fd0a201d32dc1f493bcf3fff003b6df416dea4f41046e0f37d47",
                    "docker.io/library/busybox:1.28"
                ],
                "sizeBytes": 727869
            },
            {
                "names": [
                    "registry.k8s.io/pause@sha256:7031c1b283388d2c2e09b57badb803c05ebed362dc88d84b480cc47f72a21097",
                    "registry.k8s.io/pause:3.9"
                ],
                "sizeBytes": 321520
            },
            {
                "names": [
                    "registry.k8s.io/pause@sha256:3d380ca8864549e74af4b29c10f9cb0956236dfb01c40ca076fb6c37253234db",
                    "registry.k8s.io/pause:3.6"
                ],
                "sizeBytes": 301773
            }
        ],
        "nodeInfo": {
            "architecture": "amd64",
            "bootID": "feb9c0fd-0147-4ea3-9ed8-90046e04ad6d",
            "containerRuntimeVersion": "containerd://1.6.26",
            "kernelVersion": "5.4.0-1106-gcp",
            "kubeProxyVersion": "v1.30.0",
            "kubeletVersion": "v1.30.0",
            "machineID": "2e42ca3b57184b5f966a8ae586de128a",
            "operatingSystem": "linux",
            "osImage": "Ubuntu 22.04.4 LTS",
            "systemUUID": "1c118f50-8f55-130d-4ecb-6247a1344870"
        }
    }
}

controlplane ~ ➜  kubectl get node controlplane -o json | jq .status.nodeInfo.osImages
null

controlplane ~ ➜  kubectl get node controlplane -o json | jq .status.nodeInfo
{
  "architecture": "amd64",
  "bootID": "feb9c0fd-0147-4ea3-9ed8-90046e04ad6d",
  "containerRuntimeVersion": "containerd://1.6.26",
  "kernelVersion": "5.4.0-1106-gcp",
  "kubeProxyVersion": "v1.30.0",
  "kubeletVersion": "v1.30.0",
  "machineID": "2e42ca3b57184b5f966a8ae586de128a",
  "operatingSystem": "linux",
  "osImage": "Ubuntu 22.04.4 LTS",
  "systemUUID": "1c118f50-8f55-130d-4ecb-6247a1344870"
}

controlplane ~ ➜  kubectl get node controlplane -o json | jq .status.nodeInfo.osImage
"Ubuntu 22.04.4 LTS"

controlplane ~ ➜  kubectl get node controlplane -o json | jq .status.nodeInfo.osImage > /opt/outputs/nodes_os_x43kj56.txt

controlplane ~ ➜  vi pv-analytics.yaml

controlplane ~ ➜  kubectl create -f pv-analytics.yaml
persistentvolume/pv-analytics created

controlplane ~ ➜  kubectl get persistentvolume/pv-analytics -o wide
NAME           CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS      CLAIM   STORAGECLASS   VOLUMEATTRIBUTESCLASS   REASON   AGE   VOLUMEMODE
pv-analytics   100Mi      RWX            Retain           Available                          <unset>                          14s   Filesystem

controlplane ~ ➜  kubectl expose deployment hr-web-app --type=NodePort --port=8080 --name=hr-web-app-service --dry-run=client -o yaml > hr-web-app-service.yaml 

controlplane ~ ➜  vi hr-web-app-service.yaml 

controlplane ~ ➜  cat hr-web-app-service.yaml 
apiVersion: v1
kind: Service
metadata:
  creationTimestamp: null
  labels:
    app: hr-web-app
  name: hr-web-app-service
spec:
  ports:
  - port: 8080
    protocol: TCP
    targetPort: 8080
    nodePort: 30082
  selector:
    app: hr-web-app
  type: NodePort
status:
  loadBalancer: {}

controlplane ~ ➜  

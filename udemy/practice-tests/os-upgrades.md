       Welcome to the KodeKloud Hands-On lab                                                                         
    __ ______  ____  ________ __ __    ____  __  ______ 
   / //_/ __ \/ __ \/ ____/ //_// /   / __ \/ / / / __ \
  / ,< / / / / / / / __/ / ,<  / /   / / / / / / / / / /
 / /| / /_/ / /_/ / /___/ /| |/ /___/ /_/ / /_/ / /_/ / 
/_/ |_\____/_____/_____/_/ |_/_____/\____/\____/_____/  
                                                        
            All rights reserved                                                                                      

controlplane ~ ➜  kubectl get nodes
NAME           STATUS   ROLES           AGE     VERSION
controlplane   Ready    control-plane   8m9s    v1.30.0
node01         Ready    <none>          7m24s   v1.30.0

controlplane ~ ➜  kubectl get deployments
NAME   READY   UP-TO-DATE   AVAILABLE   AGE
blue   3/3     3            3           14s

controlplane ~ ➜  kubectl get deployments -o wide
NAME   READY   UP-TO-DATE   AVAILABLE   AGE     CONTAINERS   IMAGES         SELECTOR
blue   3/3     3            3           2m21s   nginx        nginx:alpine   app=blue

controlplane ~ ➜  kubectl get pods -o wide
NAME                   READY   STATUS    RESTARTS   AGE    IP           NODE           NOMINATED NODE   READINESS GATES
blue-fffb6db8d-b52r2   1/1     Running   0          3m2s   10.244.1.2   node01         <none>           <none>
blue-fffb6db8d-gzmc8   1/1     Running   0          3m2s   10.244.0.4   controlplane   <none>           <none>
blue-fffb6db8d-p9vbm   1/1     Running   0          3m2s   10.244.1.3   node01         <none>           <none>

controlplane ~ ➜  kubectl drain --ignore-daemonsets node01
node/node01 cordoned
Warning: ignoring DaemonSet-managed Pods: kube-flannel/kube-flannel-ds-zlxh8, kube-system/kube-proxy-gzpwt
evicting pod default/blue-fffb6db8d-p9vbm
evicting pod default/blue-fffb6db8d-b52r2
pod/blue-fffb6db8d-p9vbm evicted
pod/blue-fffb6db8d-b52r2 evicted
node/node01 drained

controlplane ~ ➜  kubectl cordon node01
node/node01 already cordoned

controlplane ~ ➜  kubectl get deployments -o wide
NAME   READY   UP-TO-DATE   AVAILABLE   AGE    CONTAINERS   IMAGES         SELECTOR
blue   3/3     3            3           8m1s   nginx        nginx:alpine   app=blue

controlplane ~ ➜  kubectl get pods -o wide
NAME                   READY   STATUS    RESTARTS   AGE     IP           NODE           NOMINATED NODE   READINESS GATES
blue-fffb6db8d-242fk   1/1     Running   0          3m39s   10.244.0.5   controlplane   <none>           <none>
blue-fffb6db8d-gzmc8   1/1     Running   0          8m11s   10.244.0.4   controlplane   <none>           <none>
blue-fffb6db8d-q7vkx   1/1     Running   0          3m39s   10.244.0.6   controlplane   <none>           <none>

controlplane ~ ➜  kubectl uncordon node01
node/node01 uncordoned

controlplane ~ ➜  kubectl get pods -o wide
NAME                   READY   STATUS    RESTARTS   AGE     IP           NODE           NOMINATED NODE   READINESS GATES
blue-fffb6db8d-242fk   1/1     Running   0          4m39s   10.244.0.5   controlplane   <none>           <none>
blue-fffb6db8d-gzmc8   1/1     Running   0          9m11s   10.244.0.4   controlplane   <none>           <none>
blue-fffb6db8d-q7vkx   1/1     Running   0          4m39s   10.244.0.6   controlplane   <none>           <none>

controlplane ~ ➜  kubectl get pods -o wide
NAME                   READY   STATUS    RESTARTS   AGE     IP           NODE           NOMINATED NODE   READINESS GATES
blue-fffb6db8d-242fk   1/1     Running   0          4m44s   10.244.0.5   controlplane   <none>           <none>
blue-fffb6db8d-gzmc8   1/1     Running   0          9m16s   10.244.0.4   controlplane   <none>           <none>
blue-fffb6db8d-q7vkx   1/1     Running   0          4m44s   10.244.0.6   controlplane   <none>           <none>

controlplane ~ ➜  kubectl describe node/node01
Name:               node01
Roles:              <none>
Labels:             beta.kubernetes.io/arch=amd64
                    beta.kubernetes.io/os=linux
                    kubernetes.io/arch=amd64
                    kubernetes.io/hostname=node01
                    kubernetes.io/os=linux
Annotations:        flannel.alpha.coreos.com/backend-data: {"VNI":1,"VtepMAC":"2a:bb:bb:86:f9:55"}
                    flannel.alpha.coreos.com/backend-type: vxlan
                    flannel.alpha.coreos.com/kube-subnet-manager: true
                    flannel.alpha.coreos.com/public-ip: 192.4.54.6
                    kubeadm.alpha.kubernetes.io/cri-socket: unix:///var/run/containerd/containerd.sock
                    node.alpha.kubernetes.io/ttl: 0
                    volumes.kubernetes.io/controller-managed-attach-detach: true
CreationTimestamp:  Fri, 16 Aug 2024 02:15:30 +0000
Taints:             <none>
Unschedulable:      false
Lease:
  HolderIdentity:  node01
  AcquireTime:     <unset>
  RenewTime:       Fri, 16 Aug 2024 02:32:52 +0000
Conditions:
  Type                 Status  LastHeartbeatTime                 LastTransitionTime                Reason                       Message
  ----                 ------  -----------------                 ------------------                ------                       -------
  NetworkUnavailable   False   Fri, 16 Aug 2024 02:15:38 +0000   Fri, 16 Aug 2024 02:15:38 +0000   FlannelIsUp                  Flannel is running on this node
  MemoryPressure       False   Fri, 16 Aug 2024 02:31:21 +0000   Fri, 16 Aug 2024 02:15:30 +0000   KubeletHasSufficientMemory   kubelet has sufficient memory available
  DiskPressure         False   Fri, 16 Aug 2024 02:31:21 +0000   Fri, 16 Aug 2024 02:15:30 +0000   KubeletHasNoDiskPressure     kubelet has no disk pressure
  PIDPressure          False   Fri, 16 Aug 2024 02:31:21 +0000   Fri, 16 Aug 2024 02:15:30 +0000   KubeletHasSufficientPID      kubelet has sufficient PID available
  Ready                True    Fri, 16 Aug 2024 02:31:21 +0000   Fri, 16 Aug 2024 02:15:36 +0000   KubeletReady                 kubelet is posting ready status
Addresses:
  InternalIP:  192.4.54.6
  Hostname:    node01
Capacity:
  cpu:                36
  ephemeral-storage:  1016057248Ki
  hugepages-1Gi:      0
  hugepages-2Mi:      0
  memory:             214587056Ki
  pods:               110
Allocatable:
  cpu:                36
  ephemeral-storage:  936398358207
  hugepages-1Gi:      0
  hugepages-2Mi:      0
  memory:             214484656Ki
  pods:               110
System Info:
  Machine ID:                 69ee5c89434f4d5baea262a6ecc698fe
  System UUID:                9cf43679-f805-af36-6141-a1ba53a3d654
  Boot ID:                    3e6986cd-351a-468b-aa7f-5f60e6d68427
  Kernel Version:             5.4.0-1106-gcp
  OS Image:                   Ubuntu 22.04.4 LTS
  Operating System:           linux
  Architecture:               amd64
  Container Runtime Version:  containerd://1.6.26
  Kubelet Version:            v1.30.0
  Kube-Proxy Version:         v1.30.0
PodCIDR:                      10.244.1.0/24
PodCIDRs:                     10.244.1.0/24
Non-terminated Pods:          (2 in total)
  Namespace                   Name                     CPU Requests  CPU Limits  Memory Requests  Memory Limits  Age
  ---------                   ----                     ------------  ----------  ---------------  -------------  ---
  kube-flannel                kube-flannel-ds-zlxh8    100m (0%)     0 (0%)      50Mi (0%)        0 (0%)         17m
  kube-system                 kube-proxy-gzpwt         0 (0%)        0 (0%)      0 (0%)           0 (0%)         17m
Allocated resources:
  (Total limits may be over 100 percent, i.e., overcommitted.)
  Resource           Requests   Limits
  --------           --------   ------
  cpu                100m (0%)  0 (0%)
  memory             50Mi (0%)  0 (0%)
  ephemeral-storage  0 (0%)     0 (0%)
  hugepages-1Gi      0 (0%)     0 (0%)
  hugepages-2Mi      0 (0%)     0 (0%)
Events:
  Type     Reason                   Age                From             Message
  ----     ------                   ----               ----             -------
  Normal   Starting                 17m                kube-proxy       
  Normal   Starting                 17m                kubelet          Starting kubelet.
  Warning  InvalidDiskCapacity      17m                kubelet          invalid capacity 0 on image filesystem
  Normal   NodeHasSufficientMemory  17m (x2 over 17m)  kubelet          Node node01 status is now: NodeHasSufficientMemory
  Normal   NodeHasNoDiskPressure    17m (x2 over 17m)  kubelet          Node node01 status is now: NodeHasNoDiskPressure
  Normal   NodeHasSufficientPID     17m (x2 over 17m)  kubelet          Node node01 status is now: NodeHasSufficientPID
  Normal   NodeAllocatableEnforced  17m                kubelet          Updated Node Allocatable limit across pods
  Normal   RegisteredNode           17m                node-controller  Node node01 event: Registered Node node01 in Controller
  Normal   NodeReady                17m                kubelet          Node node01 status is now: NodeReady
  Normal   NodeNotSchedulable       5m14s              kubelet          Node node01 status is now: NodeNotSchedulable
  Normal   NodeSchedulable          57s                kubelet          Node node01 status is now: NodeSchedulable

controlplane ~ ➜  kubectl describe node/controlpane
Error from server (NotFound): nodes "controlpane" not found

controlplane ~ ✖ kubectl describe node/controlplane
Name:               controlplane
Roles:              control-plane
Labels:             beta.kubernetes.io/arch=amd64
                    beta.kubernetes.io/os=linux
                    kubernetes.io/arch=amd64
                    kubernetes.io/hostname=controlplane
                    kubernetes.io/os=linux
                    node-role.kubernetes.io/control-plane=
                    node.kubernetes.io/exclude-from-external-load-balancers=
Annotations:        flannel.alpha.coreos.com/backend-data: {"VNI":1,"VtepMAC":"c6:3e:bd:fa:5c:0a"}
                    flannel.alpha.coreos.com/backend-type: vxlan
                    flannel.alpha.coreos.com/kube-subnet-manager: true
                    flannel.alpha.coreos.com/public-ip: 192.4.54.3
                    kubeadm.alpha.kubernetes.io/cri-socket: unix:///var/run/containerd/containerd.sock
                    node.alpha.kubernetes.io/ttl: 0
                    volumes.kubernetes.io/controller-managed-attach-detach: true
CreationTimestamp:  Fri, 16 Aug 2024 02:14:45 +0000
Taints:             <none>
Unschedulable:      false
Lease:
  HolderIdentity:  controlplane
  AcquireTime:     <unset>
  RenewTime:       Fri, 16 Aug 2024 02:33:42 +0000
Conditions:
  Type                 Status  LastHeartbeatTime                 LastTransitionTime                Reason                       Message
  ----                 ------  -----------------                 ------------------                ------                       -------
  NetworkUnavailable   False   Fri, 16 Aug 2024 02:15:11 +0000   Fri, 16 Aug 2024 02:15:11 +0000   FlannelIsUp                  Flannel is running on this node
  MemoryPressure       False   Fri, 16 Aug 2024 02:30:29 +0000   Fri, 16 Aug 2024 02:14:40 +0000   KubeletHasSufficientMemory   kubelet has sufficient memory available
  DiskPressure         False   Fri, 16 Aug 2024 02:30:29 +0000   Fri, 16 Aug 2024 02:14:40 +0000   KubeletHasNoDiskPressure     kubelet has no disk pressure
  PIDPressure          False   Fri, 16 Aug 2024 02:30:29 +0000   Fri, 16 Aug 2024 02:14:40 +0000   KubeletHasSufficientPID      kubelet has sufficient PID available
  Ready                True    Fri, 16 Aug 2024 02:30:29 +0000   Fri, 16 Aug 2024 02:15:08 +0000   KubeletReady                 kubelet is posting ready status
Addresses:
  InternalIP:  192.4.54.3
  Hostname:    controlplane
Capacity:
  cpu:                36
  ephemeral-storage:  1016057248Ki
  hugepages-1Gi:      0
  hugepages-2Mi:      0
  memory:             214587056Ki
  pods:               110
Allocatable:
  cpu:                36
  ephemeral-storage:  936398358207
  hugepages-1Gi:      0
  hugepages-2Mi:      0
  memory:             214484656Ki
  pods:               110
System Info:
  Machine ID:                 2e42ca3b57184b5f966a8ae586de128a
  System UUID:                1a5d0c79-cc3c-637d-7715-d7952ec4ba25
  Boot ID:                    6eb1476b-99d1-462b-b939-36383c2e6916
  Kernel Version:             5.4.0-1106-gcp
  OS Image:                   Ubuntu 22.04.4 LTS
  Operating System:           linux
  Architecture:               amd64
  Container Runtime Version:  containerd://1.6.26
  Kubelet Version:            v1.30.0
  Kube-Proxy Version:         v1.30.0
PodCIDR:                      10.244.0.0/24
PodCIDRs:                     10.244.0.0/24
Non-terminated Pods:          (11 in total)
  Namespace                   Name                                    CPU Requests  CPU Limits  Memory Requests  Memory Limits  Age
  ---------                   ----                                    ------------  ----------  ---------------  -------------  ---
  default                     blue-fffb6db8d-242fk                    0 (0%)        0 (0%)      0 (0%)           0 (0%)         6m10s
  default                     blue-fffb6db8d-gzmc8                    0 (0%)        0 (0%)      0 (0%)           0 (0%)         10m
  default                     blue-fffb6db8d-q7vkx                    0 (0%)        0 (0%)      0 (0%)           0 (0%)         6m10s
  kube-flannel                kube-flannel-ds-rbstd                   100m (0%)     0 (0%)      50Mi (0%)        0 (0%)         18m
  kube-system                 coredns-768b85b76f-kt649                100m (0%)     0 (0%)      70Mi (0%)        170Mi (0%)     18m
  kube-system                 coredns-768b85b76f-r9zlv                100m (0%)     0 (0%)      70Mi (0%)        170Mi (0%)     18m
  kube-system                 etcd-controlplane                       100m (0%)     0 (0%)      100Mi (0%)       0 (0%)         19m
  kube-system                 kube-apiserver-controlplane             250m (0%)     0 (0%)      0 (0%)           0 (0%)         18m
  kube-system                 kube-controller-manager-controlplane    200m (0%)     0 (0%)      0 (0%)           0 (0%)         18m
  kube-system                 kube-proxy-qkf54                        0 (0%)        0 (0%)      0 (0%)           0 (0%)         18m
  kube-system                 kube-scheduler-controlplane             100m (0%)     0 (0%)      0 (0%)           0 (0%)         18m
Allocated resources:
  (Total limits may be over 100 percent, i.e., overcommitted.)
  Resource           Requests    Limits
  --------           --------    ------
  cpu                950m (2%)   0 (0%)
  memory             290Mi (0%)  340Mi (0%)
  ephemeral-storage  0 (0%)      0 (0%)
  hugepages-1Gi      0 (0%)      0 (0%)
  hugepages-2Mi      0 (0%)      0 (0%)
Events:
  Type     Reason                   Age                From             Message
  ----     ------                   ----               ----             -------
  Normal   Starting                 18m                kube-proxy       
  Normal   NodeHasSufficientMemory  19m (x8 over 19m)  kubelet          Node controlplane status is now: NodeHasSufficientMemory
  Normal   NodeHasNoDiskPressure    19m (x7 over 19m)  kubelet          Node controlplane status is now: NodeHasNoDiskPressure
  Normal   NodeHasSufficientPID     19m (x7 over 19m)  kubelet          Node controlplane status is now: NodeHasSufficientPID
  Normal   NodeAllocatableEnforced  19m                kubelet          Updated Node Allocatable limit across pods
  Warning  InvalidDiskCapacity      18m                kubelet          invalid capacity 0 on image filesystem
  Normal   NodeAllocatableEnforced  18m                kubelet          Updated Node Allocatable limit across pods
  Normal   NodeHasSufficientMemory  18m                kubelet          Node controlplane status is now: NodeHasSufficientMemory
  Normal   NodeHasNoDiskPressure    18m                kubelet          Node controlplane status is now: NodeHasNoDiskPressure
  Normal   NodeHasSufficientPID     18m                kubelet          Node controlplane status is now: NodeHasSufficientPID
  Normal   Starting                 18m                kubelet          Starting kubelet.
  Normal   RegisteredNode           18m                node-controller  Node controlplane event: Registered Node controlplane in Controller
  Normal   NodeReady                18m                kubelet          Node controlplane status is now: NodeReady

controlplane ~ ➜  kubectl drain node01 --ignore-daemonsets
node/node01 cordoned
error: unable to drain node "node01" due to error:cannot delete cannot delete Pods that declare no controller (use --force to override): default/hr-app, continuing command...
There are pending nodes to be drained:
 node01
cannot delete cannot delete Pods that declare no controller (use --force to override): default/hr-app

controlplane ~ ✖ kubectl get pods -o wide
NAME                   READY   STATUS    RESTARTS   AGE     IP           NODE           NOMINATED NODE   READINESS GATES
blue-fffb6db8d-242fk   1/1     Running   0          15m     10.244.0.5   controlplane   <none>           <none>
blue-fffb6db8d-gzmc8   1/1     Running   0          19m     10.244.0.4   controlplane   <none>           <none>
blue-fffb6db8d-q7vkx   1/1     Running   0          15m     10.244.0.6   controlplane   <none>           <none>
hr-app                 1/1     Running   0          8m50s   10.244.1.4   node01         <none>           <none>

controlplane ~ ➜  kubectl drain node01 --ignore-daemonsets 
node/node01 already cordoned
error: unable to drain node "node01" due to error:cannot delete cannot delete Pods that declare no controller (use --force to override): default/hr-app, continuing command...
There are pending nodes to be drained:
 node01
cannot delete cannot delete Pods that declare no controller (use --force to override): default/hr-app

controlplane ~ ✖ kubectl drain node01 --ignore-daemonsets  --force
node/node01 already cordoned
Warning: ignoring DaemonSet-managed Pods: kube-flannel/kube-flannel-ds-zlxh8, kube-system/kube-proxy-gzpwt; deleting Pods that declare no controller: default/hr-app
evicting pod default/hr-app

pod/hr-app evicted
node/node01 drained

controlplane ~ ➜  

controlplane ~ ➜  kubectl get pods -o wide
NAME                   READY   STATUS    RESTARTS   AGE   IP           NODE           NOMINATED NODE   READINESS GATES
blue-fffb6db8d-242fk   1/1     Running   0          18m   10.244.0.5   controlplane   <none>           <none>
blue-fffb6db8d-gzmc8   1/1     Running   0          22m   10.244.0.4   controlplane   <none>           <none>
blue-fffb6db8d-q7vkx   1/1     Running   0          18m   10.244.0.6   controlplane   <none>           <none>

controlplane ~ ➜  #kubectl get pods -o wide

controlplane ~ ➜  kubectl uncordon node01
node/node01 already uncordoned

controlplane ~ ➜  kubectl cordon node01
node/node01 cordoned

controlplane ~ ➜  kubectl get pods -o wide
NAME                      READY   STATUS    RESTARTS   AGE   IP           NODE           NOMINATED NODE   READINESS GATES
blue-fffb6db8d-242fk      1/1     Running   0          19m   10.244.0.5   controlplane   <none>           <none>
blue-fffb6db8d-gzmc8      1/1     Running   0          24m   10.244.0.4   controlplane   <none>           <none>
blue-fffb6db8d-q7vkx      1/1     Running   0          19m   10.244.0.6   controlplane   <none>           <none>
hr-app-74c9788784-vg7jl   1/1     Running   0          53s   10.244.1.5   node01         <none>           <none>

controlplane ~ ➜  kubectl drain node01 --ignore-daemonsets  --force
node/node01 already cordoned
Warning: ignoring DaemonSet-managed Pods: kube-flannel/kube-flannel-ds-zlxh8, kube-system/kube-proxy-gzpwt
evicting pod default/hr-app-74c9788784-vg7jl
    
pod/hr-app-74c9788784-vg7jl evicted
node/node01 drained

controlplane ~ ➜  

controlplane ~ ➜  

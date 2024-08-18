       Welcome to the KodeKloud Hands-On lab                                                                         
    __ ______  ____  ________ __ __    ____  __  ______ 
   / //_/ __ \/ __ \/ ____/ //_// /   / __ \/ / / / __ \
  / ,< / / / / / / / __/ / ,<  / /   / / / / / / / / / /
 / /| / /_/ / /_/ / /___/ /| |/ /___/ /_/ / /_/ / /_/ / 
/_/ |_\____/_____/_____/_/ |_/_____/\____/\____/_____/  
                                                        
            All rights reserved                                                                                      

controlplane ~ ➜  kubectl get demonsets
error: the server doesn't have a resource type "demonsets"

controlplane ~ ✖ kubectl get demonset
error: the server doesn't have a resource type "demonset"

controlplane ~ ✖ kubectl get demonset --all-namespaces
error: the server doesn't have a resource type "demonset"

controlplane ~ ✖ kubectl get demonsets --all-namespaces
error: the server doesn't have a resource type "demonsets"

controlplane ~ ✖ kubectl get pods --all-namespaces
NAMESPACE      NAME                                   READY   STATUS    RESTARTS   AGE
kube-flannel   kube-flannel-ds-kpdjw                  1/1     Running   0          14m
kube-system    coredns-768b85b76f-qztdf               1/1     Running   0          14m
kube-system    coredns-768b85b76f-rqfjg               1/1     Running   0          14m
kube-system    etcd-controlplane                      1/1     Running   0          15m
kube-system    kube-apiserver-controlplane            1/1     Running   0          15m
kube-system    kube-controller-manager-controlplane   1/1     Running   0          15m
kube-system    kube-proxy-j4wz5                       1/1     Running   0          14m
kube-system    kube-scheduler-controlplane            1/1     Running   0          15m

controlplane ~ ➜  kubectl get DaemonSets --all-namespaces
NAMESPACE      NAME              DESIRED   CURRENT   READY   UP-TO-DATE   AVAILABLE   NODE SELECTOR            AGE
kube-flannel   kube-flannel-ds   1         1         1       1            1           <none>                   16m
kube-system    kube-proxy        1         1         1       1            1           kubernetes.io/os=linux   16m

controlplane ~ ➜  kubectl get nodes --all-namespaces
NAME           STATUS   ROLES           AGE   VERSION
controlplane   Ready    control-plane   18m   v1.30.0

controlplane ~ ➜  kubectl get pod/kube-flannel-ds  --namespace=kube-flannel -o wide
Error from server (NotFound): pods "kube-flannel-ds" not found

controlplane ~ ✖ kubectl get DaemonSets/kube-flannel-ds  --namespace=kube-flannel -o wide
NAME              DESIRED   CURRENT   READY   UP-TO-DATE   AVAILABLE   NODE SELECTOR   AGE   CONTAINERS     IMAGES                              SELECTOR
kube-flannel-ds   1         1         1       1            1           <none>          22m   kube-flannel   docker.io/flannel/flannel:v0.23.0   app=flannel,k8s-app=flannel

controlplane ~ ➜  kubectl create daemonsets elasticsearch --image=registry.k8s.io/fluentd-elasticsearch:1.20 --namespace=kube-system
error: unknown flag: --image
See 'kubectl create --help' for usage.

controlplane ~ ✖ kubectl create daemonsets elasticsearch  --namespace=kube-system
Error: must specify one of -f and -k

error: unknown command "daemonsets elasticsearch"
See 'kubectl create -h' for help and examples

controlplane ~ ✖ vi elasticsearch.yaml

controlplane ~ ➜  kubectl create -f  elasticsearch.yaml
daemonset.apps/elasticsearch created

controlplane ~ ➜  

```yaml
apiVersion: apps/v1
kind: DaemonSet
metadata:
  name: elasticsearch
  namespace: kube-system
  labels:
    k8s-app: fluentd-logging
spec:
  selector:
    matchLabels:
      name: fluentd-elasticsearch
  template:
    metadata:
      labels:
        name: fluentd-elasticsearch
    spec:
      tolerations:
      # these tolerations are to have the daemonset runnable on control plane nodes
      # remove them if your control plane nodes should not run pods
      - key: node-role.kubernetes.io/control-plane
        operator: Exists
        effect: NoSchedule
      - key: node-role.kubernetes.io/master
        operator: Exists
        effect: NoSchedule
      containers:
      - name: fluentd-elasticsearch
        image: registry.k8s.io/fluentd-elasticsearch:1.20
        resources:
          limits:
            memory: 200Mi
          requests:
            cpu: 100m
            memory: 200Mi
        volumeMounts:
        - name: varlog
          mountPath: /var/log
      # it may be desirable to set a high priority class to ensure that a DaemonSet Pod
      # preempts running Pods
      # priorityClassName: important
      terminationGracePeriodSeconds: 30
      volumes:
      - name: varlog
        hostPath:
          path: /var/log
```

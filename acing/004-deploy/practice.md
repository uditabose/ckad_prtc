
<p>
 Apply the label ‘disk=ssd’ to the worker node named
 ‘kind-worker’ and schedule a pod named ‘ssd-pod’ to
 ‘kind-worker’ node by using node selector
</p>

---

### Verify current state
```bash
kubectl get no --show-labels

NAME                  STATUS   ROLES           AGE   VERSION   LABELS
acing-control-plane   Ready    control-plane   24h   v1.25.3   beta.kubernetes.io/arch=arm64,beta.kubernetes.io/os=linux,kubernetes.io/arch=arm64,kubernetes.io/hostname=acing-control-plane,kubernetes.io/os=linux,node-role.kubernetes.io/control-plane=,node.kubernetes.io/exclude-from-external-load-balancers=
acing-worker          Ready    <none>          24h   v1.25.3   beta.kubernetes.io/arch=arm64,beta.kubernetes.io/os=linux,kubernetes.io/arch=arm64,kubernetes.io/hostname=acing-worker,kubernetes.io/os=linux
acing-worker2         Ready    <none>          24h   v1.25.3   beta.kubernetes.io/arch=arm64,beta.kubernetes.io/os=linux,kubernetes.io/arch=arm64,kubernetes.io/hostname=acing-worker2,kubernetes.io/os=linux

```

```bash
kubectl config view --context=acing

apiVersion: v1
clusters:
- cluster:
    certificate-authority-data: DATA+OMITTED
    server: https://acing-control-plane:6443
  name: acing
contexts:
- context:
    cluster: acing
    user: kubernetes-admin
  name: kubernetes-admin@acing
current-context: kubernetes-admin@acing
kind: Config
preferences: {}
users:
- name: kubernetes-admin
  user:
    client-certificate-data: REDACTED
    client-key-data: REDACTED
```

---

### Create a pod yml

```bash
# run in host, not in control-plane

kubectl run ssd-pod --context=acing --image=nginx --dry-run=client -o yaml > ssd-pod.yaml
```

### Apply the worker node label
```bash
kubectl label no acing-worker disktype=ssd

node/acing-worker labeled
```

```bash
kubectl apply -f ssd-pod.yaml --context=acing

pod/ssd-pod created
```

```bash
kubectl get po -o wide
NAME      READY   STATUS    RESTARTS   AGE   IP           NODE           NOMINATED NODE   READINESS G
ssd-pod   1/1     Running   0          35s   10.244.1.2   acing-worker   <none>           <none>
```

---
### Node selection

```bash
kubectl -n kube-system get po

NAME                                          READY   STATUS    RESTARTS   AGE
coredns-565d847f94-m89qd                      1/1     Running   0          3d
coredns-565d847f94-nh92p                      1/1     Running   0          3d
etcd-acing-control-plane                      1/1     Running   0          3d
kindnet-5thgl                                 1/1     Running   0          3d
kindnet-bw5zp                                 1/1     Running   0          3d
kindnet-gfbqg                                 1/1     Running   0          3d
kube-apiserver-acing-control-plane            1/1     Running   0          3d
kube-controller-manager-acing-control-plane   1/1     Running   0          3d
kube-proxy-6z4z4                              1/1     Running   0          3d
kube-proxy-g627l                              1/1     Running   0          3d
kube-proxy-v76cb                              1/1     Running   0          3d
kube-scheduler-acing-control-plane            1/1     Running   0          3d
```

```bash
kubectl -n kube-system get po kindnet-5thgl -o yaml | grep nodeName -a3

  dnsPolicy: ClusterFirst
  enableServiceLinks: true
  hostNetwork: true
  __nodeName__: acing-worker2
  preemptionPolicy: PreemptLowerPriority
  priority: 0
  restartPolicy: Always
```

```bash
kubectl get po -A

kubectl get ds
No resources found in default namespace.
```


### Setup affinity

```bash
kubectl run affinity --image nginx --dry-run=client -o yaml > affinity.yaml

kubectl apply -f affinity.yaml
pod/affinity created
```

```bash
kubectl get pod -o wide
NAME       READY   STATUS    RESTARTS   AGE   IP           NODE            NOMINATED NODE   READINESS GATES
affinity   1/1     Running   0          41s   10.244.2.2   acing-worker2   <none>           <none>
ssd-pod    1/1     Running   0          2d    10.244.1.2   acing-worker    <none>           <none>

kubectl get pod affinity -o yaml
```

```bash
# try again with pre-created pod yaml
kubectl apply -f https://raw.githubusercontent.com/chadmcrowell/k8s/main/manifests/pod-node- affinity.yaml
```


### Schedule a pod in a node with nginx
```bash
kubectl run nginx --image=nginx
pod/nginx created

 kubectl get po -o wide
NAME       READY   STATUS    RESTARTS   AGE     IP           NODE            NOMINATED NODE   READINESS GATES
affinity   1/1     Running   0          45h     10.244.2.2   acing-worker2   <none>           <none>
nginx      1/1     Running   0          22s     10.244.1.3   acing-worker    <none>           <none>
ssd-pod    1/1     Running   0          3d21h   10.244.1.2   acing-worker    <none>           <none>
```

```bash
curl -O https://raw.githubusercontent.com/chadmcrowell/k8s/main/manifests/pod-node-affinity.yaml
```

```bash
kubectl apply -f  pod-with-node-affinity.yaml
pod/pod-affinity created
```

## Setup helm
`brew install helm`
`helm version --short`

```bash
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh

helm repo add hashicorp https://helm.releases.hashicorp.com

helm repo list
NAME            URL
hashicorp       https://helm.releases.hashicorp.com

helm search repo vault
NAME            CHART VERSION   APP VERSION     DESCRIPTION
hashicorp/vault 0.23.0          1.12.1          Official HashiCorp Vault Chart

helm repo add metallb https://metallb.github.io/metallb
"metallb" has been added to your repositories

helm repo list
NAME            URL
hashicorp       https://helm.releases.hashicorp.com
metallb          https://metallb.github.io/metallb

helm search repo metallb
NAME            CHART VERSION   APP VERSION     DESCRIPTION
metallb/metallb 0.13.9          v0.13.9         A network load-balancer implementation for Kube...
```

### Helm values

```bash
helm install metallb metallb/metallb --values values.yaml

NAME: metallb
LAST DEPLOYED: Tue Feb 28 02:18:25 2023
NAMESPACE: default
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
MetalLB is now running in the cluster.

Now you can configure it via its CRs. Please refer to the metallb official docs
on how to use the CRs.
```








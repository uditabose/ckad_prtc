
## What happens when advanced cluster is setup

### Create cluster

```bash
kind create cluster --config config_advanced.yaml --name acing-advanced


Creating cluster "acing-advanced" ...
 ✓ Ensuring node image (kindest/node:v1.29.2) 🖼
 ✓ Preparing nodes 📦
 ✓ Writing configuration 📜
 ✓ Starting control-plane 🕹️
 ✓ Installing CNI 🔌
 ✓ Installing StorageClass 💾
Set kubectl context to "kind-acing-advanced"
You can now use your cluster with:

kubectl cluster-info --context kind-acing-advanced

Thanks for using kind! 😊
```

### View things
```bash
kubectl cluster-info --context kind-acing-advanced

Kubernetes control plane is running at https://127.0.0.1:54816
CoreDNS is running at https://127.0.0.1:54816/api/v1/namespaces/kube-system/services/kube-dns:dns/proxy

To further debug and diagnose cluster problems, use 'kubectl cluster-info dump'.
```

### View the nodes
```bash
kubectl get no
NAME                           STATUS   ROLES           AGE    VERSION
acing-advanced-control-plane   Ready    control-plane   106s   v1.29.2
```

### show labels
```bash
kubectl get no --show-labels

NAME                           STATUS   ROLES           AGE     VERSION   LABELS
acing-advanced-control-plane   Ready    control-plane   2m47s   v1.29.2   beta.kubernetes.io/arch=arm64,beta.kubernetes.io/os=linux,ingress-ready=true,kubernetes.io/arch=arm64,kubernetes.io/hostname=acing-advanced-control-plane,kubernetes.io/os=linux,node-role.kubernetes.io/control-plane=
```

### Delete the cluster
```bash
kind delete cluster --name kind-acing-advanced
```
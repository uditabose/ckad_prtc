## Create cluster
- keep docker running
- keep kubernetes running

```bash
 kind create cluster --name acing
Creating cluster "acing" ...
 ✓ Ensuring node image (kindest/node:v1.25.3) 🖼
 ✓ Preparing nodes 📦
 ✓ Writing configuration 📜
 ✓ Starting control-plane 🕹️
 ✓ Installing CNI 🔌
 ✓ Installing StorageClass 💾
Set kubectl context to "kind-acing"
You can now use your cluster with:

kubectl cluster-info --context kind-acing

Have a question, bug, or feature request? Let us know! https://kind.sigs.k8s.io/#community 🙂
```

### Get to the cluster
`docker exec -it acing-control-plane bash`

### Find context

```bash
kubectl config get-contexts
CURRENT   NAME                     CLUSTER   AUTHINFO           NAMESPACE
*         kubernetes-admin@acing   acing     kubernetes-admin
```

```bash
kubectl cluster-info
Kubernetes control plane is running at https://acing-control-plane:6443
CoreDNS is running at https://acing-control-plane:6443/api/v1/namespaces/kube-system/services/kube-dns:dns/proxy

To further debug and diagnose cluster problems, use 'kubectl cluster-info dump'.
```

```bash
kubectl cluster-info --context  kubernetes-admin@acing
Kubernetes control plane is running at https://acing-control-plane:6443
CoreDNS is running at https://acing-control-plane:6443/api/v1/namespaces/kube-system/services/kube-dns:dns/proxy

To further debug and diagnose cluster problems, use 'kubectl cluster-info dump'.
```

## Create a multi-node cluster

```bash
cat << EOF | tee config.yaml
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
nodes:
- role: control-plane
- role: worker
- role: worker
EOF
```

```bash
kind create cluster --config config.yaml --name acing

Creating cluster "acing" ...
 ✓ Ensuring node image (kindest/node:v1.25.3) 🖼
 ✓ Preparing nodes 📦 📦 📦
 ✓ Writing configuration 📜
 ✓ Starting control-plane 🕹️
 ✓ Installing CNI 🔌
 ✓ Installing StorageClass 💾
 ✓ Joining worker nodes 🚜
Set kubectl context to "kind-acing"
You can now use your cluster with:

kubectl cluster-info --context kind-acing

Have a question, bug, or feature request? Let us know! https://kind.sigs.k8s.io/#community 🙂
```

### Verify

```bash
 kubectl cluster-info --context kind-acing
Kubernetes control plane is running at https://127.0.0.1:63067
CoreDNS is running at https://127.0.0.1:63067/api/v1/namespaces/kube-system/services/kube-dns:dns/proxy

To further debug and diagnose cluster problems, use 'kubectl cluster-info dump'.
```

```bash
kubectl get no
NAME                  STATUS   ROLES           AGE     VERSION
acing-control-plane   Ready    control-plane   3m18s   v1.25.3
acing-worker          Ready    <none>          2m58s   v1.25.3
acing-worker2         Ready    <none>          2m58s   v1.25.3
```
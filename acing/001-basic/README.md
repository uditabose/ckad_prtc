## Setup of kind cluster

> from https://github.com/kubernetes-sigs/kind

Steps
- install golang
    - https://go.dev/dl/
    - add `/usr/local/go/bin` in PATH
    - `source ~/.zshrc`
- `go install sigs.k8s.io/kind@v0.17.0`
    - add $HOME/go/bin in PATH
```bash
 kind create cluster
Creating cluster "kind" ...
 ✓ Ensuring node image (kindest/node:v1.25.3) 🖼
 ✓ Preparing nodes 📦
 ✓ Writing configuration 📜
 ✓ Starting control-plane 🕹️
 ✓ Installing CNI 🔌
 ✓ Installing StorageClass 💾
Set kubectl context to "kind-kind"
You can now use your cluster with:

kubectl cluster-info --context kind-kind

Not sure what to do next? 😅  Check out https://kind.sigs.k8s.io/docs/user/quick-start/
```
---
```bash
 kubectl cluster-info --context kind-kind
Kubernetes control plane is running at https://127.0.0.1:63073
CoreDNS is running at https://127.0.0.1:63073/api/v1/namespaces/kube-system/services/kube-dns:dns/proxy

To further debug and diagnose cluster problems, use 'kubectl cluster-info dump'.
```
## A custom CNI cluster

```bash
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
networking:
    disableDefaultCNI: true
nodes:
    role: control-plane
    role: worker
```

```bash
kind create cluster --image kindest/node:v1.25.0-beta.0 --config cni_cluster.yaml --name cni-acing

Creating cluster "cni-acing" ...
 ✓ Ensuring node image (kindest/node:v1.25.0-beta.0) 🖼
 ✓ Preparing nodes 📦 📦
 ✓ Writing configuration 📜
 ✓ Starting control-plane 🕹️
 ✓ Installing StorageClass 💾
 ✓ Joining worker nodes 🚜
Set kubectl context to "kind-cni-acing"
You can now use your cluster with:

kubectl cluster-info --context kind-cni-acing

Thanks for using kind! 😊

```

```bash
Kubernetes control plane is running at https://127.0.0.1:63334
CoreDNS is running at https://127.0.0.1:63334/api/v1/namespaces/kube-system/services/kube-dns:dns/proxy

To further debug and diagnose cluster problems, use 'kubectl cluster-info dump'.
```

### From control-pane

#### setup bridge

`docker exec -it cni-acing-control-plane bash`

```bash
apt update; apt install wget
wget https://github.com/containernetworking/plugins/releases/download/v1.1.1/cni-plugins-linux-amd64-v1.1.1.tgz
tar -xvf cni-plugins-linux-amd64-v1.1.1.tgz

./
./macvlan
./static
./vlan
./portmap
./host-local
./vrf
./bridge
./tuning
./firewall
./host-device
./sbr
./loopback
./dhcp
./ptp
./ipvlan
./bandwidth

mv bridge /opt/cni/bin/

```

#### setup flannel
```bash
kubectl apply -f https://raw.githubusercontent.com/flannel-io/flannel/master/Documentation/kube-flannel.yml
```

```bash
kubectl get no

NAME                      STATUS   ROLES           AGE   VERSION
cni-acing-control-plane   Ready    control-plane   16m   v1.25.0-beta.0
cni-acing-worker          Ready    <none>          16m   v1.25.0-beta.0
```

```bash
kubectl get po -A

NAMESPACE            NAME                                              READY   STATUS    RESTARTS   AGE
kube-flannel         kube-flannel-ds-b96qq                             1/1     Running   0          2m32s
kube-flannel         kube-flannel-ds-lcgqv                             1/1     Running   0          2m32s
kube-system          coredns-565d847f94-4g7th                          1/1     Running   0          17m
kube-system          coredns-565d847f94-sn9vq                          1/1     Running   0          17m
kube-system          etcd-cni-acing-control-plane                      1/1     Running   0          17m
kube-system          kube-apiserver-cni-acing-control-plane            1/1     Running   0          17m
kube-system          kube-controller-manager-cni-acing-control-plane   1/1     Running   0          17m
kube-system          kube-proxy-l5k5w                                  1/1     Running   0          17m
kube-system          kube-proxy-vbzcx                                  1/1     Running   0          17m
kube-system          kube-scheduler-cni-acing-control-plane            1/1     Running   0          17m
local-path-storage   local-path-provisioner-684f458cdd-mtwhx           1/1     Running   0          17m
```

### From node

#### setup bridge

`docker exec -it cni-acing-worker bash`

```bash
apt update; apt install wget
wget https://github.com/containernetworking/plugins/releases/download/v1.1.1/cni-plugins-linux-amd64-v1.1.1.tgz
tar -xvf cni-plugins-linux-amd64-v1.1.1.tgz

./
./macvlan
./static
./vlan
./portmap
./host-local
./vrf
./bridge
./tuning
./firewall
./host-device
./sbr
./loopback
./dhcp
./ptp
./ipvlan
./bandwidth

mv bridge /opt/cni/bin/

```

#### setup flannel


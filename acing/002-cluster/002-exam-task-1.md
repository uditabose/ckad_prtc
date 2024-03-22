# Kubernetes version upgrade

> There’s a need for company X to upgrade the Kubernetes control- ler to version 1.24 or higher, due to a bug that affects Pod scheduling. Perform the update with minimal downtime and loss of service.
>

- [Kubernetes version upgrade](#kubernetes-version-upgrade)
  - [Create cluster](#create-cluster)
  - [Go into control pane](#go-into-control-pane)
    - [inside the control pane](#inside-the-control-pane)
    - [what's the plan of upgrade](#whats-the-plan-of-upgrade)
    - [prep machine for upgrade](#prep-machine-for-upgrade)


## Create cluster

`kind create cluster --config /Users/uditabose/spaces/ckad_prtc/acing/000-setup/config.yaml --name acing-multi`

---

```bash
Creating cluster "acing-multi" ...
 ✓ Ensuring node image (kindest/node:v1.29.2) 🖼
 ✓ Preparing nodes 📦 📦 📦
 ✓ Writing configuration 📜
 ✓ Starting control-plane 🕹️
 ✓ Installing CNI 🔌
 ✓ Installing StorageClass 💾
 ✓ Joining worker nodes 🚜
Set kubectl context to "kind-acing-multi"
You can now use your cluster with:

kubectl cluster-info --context kind-acing-multi

Thanks for using kind! 😊
```

## Go into control pane

`docker exec -it acing-multi-control-plane bash`

---

```bash
root@acing-multi-control-plane:/# ls -l
total 56
drwxr-xr-x  90 root root 4096 Feb 12 22:48 LICENSES
lrwxrwxrwx   1 root root    7 Jan 30 19:44 bin -> usr/bin
drwxr-xr-x   2 root root 4096 Dec  9 21:08 boot
drwxr-xr-x   8 root root 3000 Feb 22 03:37 dev
drwxr-xr-x   1 root root 4096 Feb 22 03:37 etc
drwxr-xr-x   2 root root 4096 Dec  9 21:08 home
drwxr-xr-x   1 root root 4096 Feb 22 03:37 kind
lrwxrwxrwx   1 root root    7 Jan 30 19:44 lib -> usr/lib
drwxr-xr-x   2 root root 4096 Jan 30 19:44 media
drwxr-xr-x   2 root root 4096 Jan 30 19:44 mnt
drwxr-xr-x   1 root root 4096 Feb 14 22:27 opt
dr-xr-xr-x 416 root root    0 Feb 22 03:37 proc
drwx------   1 root root 4096 Feb 22 03:37 root
drwxr-xr-x  11 root root  240 Feb 22 03:37 run
lrwxrwxrwx   1 root root    8 Jan 30 19:44 sbin -> usr/sbin
drwxr-xr-x   2 root root 4096 Jan 30 19:44 srv
dr-xr-xr-x  12 root root    0 Feb 22 03:37 sys
drwxrwxrwt   2 root root   40 Feb 22 03:37 tmp
drwxr-xr-x   1 root root 4096 Jan 30 19:44 usr
drwxr-xr-x  11 root root 4096 Feb 22 03:37 var
```

### inside the control pane

`kubectl get po -n kube-system`

---

```bash
NAME                                                READY   STATUS    RESTARTS   AGE
coredns-76f75df574-gqjd8                            1/1     Running   0          10m
coredns-76f75df574-wdxsg                            1/1     Running   0          10m
etcd-acing-multi-control-plane                      1/1     Running   0          10m
kindnet-8rdtv                                       1/1     Running   0          10m
kindnet-nhqkp                                       1/1     Running   0          10m
kindnet-wrf9n                                       1/1     Running   0          10m
kube-apiserver-acing-multi-control-plane            1/1     Running   0          10m
kube-controller-manager-acing-multi-control-plane   1/1     Running   0          10m
kube-proxy-bxmwz                                    1/1     Running   0          10m
kube-proxy-fhrfz                                    1/1     Running   0          10m
kube-proxy-flxjw                                    1/1     Running   0          10m
kube-scheduler-acing-multi-control-plane            1/1     Running   0          10m
```

### what's the plan of upgrade

`kubeadm upgrade plan`

---

```bash
[upgrade/config] Making sure the configuration is correct:
[upgrade/config] Reading configuration from the cluster...
[upgrade/config] FYI: You can look at this config file with 'kubectl -n kube-system get cm kubeadm-config -o yaml'
[preflight] Running pre-flight checks.
[upgrade] Running cluster health checks
[upgrade] Fetching available versions to upgrade to
[upgrade/versions] Cluster version: v1.29.2
[upgrade/versions] kubeadm version: v1.29.2
[upgrade/versions] Target version: v1.29.2
[upgrade/versions] Latest version in the v1.29 series: v1.29.2
```

### prep machine for upgrade

- `curl -fsSLo /etc/apt/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg`
- curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
- `echo "deb [signed-by=/etc/apt/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | tee /etc/apt/sources.list.d/kubernetes.list`
- echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | tee /etc/apt/sources.list.d/kubernetes.list
- `apt update; apt install -y kubeadm=1.29.2`

```bash
Reading package lists... Done
W: GPG error: https://packages.cloud.google.com/apt kubernetes-xenial InRelease: The following signatures couldn't be verified because the public key is not available: NO_PUBKEY B53DC80D13EDEF05
E: The repository 'https://apt.kubernetes.io kubernetes-xenial InRelease' is not signed.
N: Updating from such a repository can't be done securely, and is therefore disabled by default.
N: See apt-secure(8) manpage for repository creation and user configuration details.
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
E: Unable to locate package kubeadm
```

-  sudo curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://dl.k8s.io/apt/doc/apt-key.gpg
- echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | tee /etc/apt/sources.list.d/kubernetes.list


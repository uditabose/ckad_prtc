#!/bin/bash

## Task - 1
<<taskdescription 
upgrade  Kubernetes controller to version 1.24 or higher, minimal downtime and loss of service
taskdescription

# step-1: go inside the container
# ----------------------------
docker exec -it kind-control-plane bash 

# step-2: check what version kubeadm needs upgraded to
# upgrade the kubeadm in the control-plane container 🔼
# ----------------------------
kubeadm upgrade plan
<<output
[upgrade/config] Making sure the configuration is correct:
[upgrade/config] Reading configuration from the cluster...
[upgrade/config] FYI: You can look at this config file with 'kubectl -n kube-system get cm kubeadm-config -o yaml'
[preflight] Running pre-flight checks.
[upgrade] Running cluster health checks
[upgrade] Fetching available versions to upgrade to
[upgrade/versions] Cluster version: v1.25.3
[upgrade/versions] kubeadm version: v1.25.3
I0103 01:30:26.841316    1743 version.go:256] remote version is much newer: v1.26.0; falling back to: stable-1.25
[upgrade/versions] Target version: v1.25.5
[upgrade/versions] Latest version in the v1.25 series: v1.25.5

Components that must be upgraded manually after you have upgraded the control plane with 'kubeadm upgrade apply':
COMPONENT   CURRENT       TARGET
kubelet     1 x v1.25.3   v1.25.5

Upgrade to the latest version in the v1.25 series:

COMPONENT                 CURRENT   TARGET
kube-apiserver            v1.25.3   v1.25.5
kube-controller-manager   v1.25.3   v1.25.5
kube-scheduler            v1.25.3   v1.25.5
kube-proxy                v1.25.3   v1.25.5
CoreDNS                   v1.9.3    v1.9.3
etcd                      3.5.4-0   3.5.4-0

You can now apply the upgrade by executing the following command:

        kubeadm upgrade apply v1.25.5

Note: Before you can perform this upgrade, you have to update kubeadm to v1.25.5.

_____________________________________________________________________


The table below shows the current state of component configs as understood by this version of kubeadm.
Configs that have a "yes" mark in the "MANUAL UPGRADE REQUIRED" column require manual config upgrade or
resetting to kubeadm defaults before a successful upgrade can be performed. The version to manually
upgrade to is denoted in the "PREFERRED VERSION" column.

API GROUP                 CURRENT VERSION   PREFERRED VERSION   MANUAL UPGRADE REQUIRED
kubeproxy.config.k8s.io   v1alpha1          v1alpha1            no
kubelet.config.k8s.io     v1beta1           v1beta1             no
_____________________________________________________________________
output


# step-3: upgrade kubeadm
# ----------------------------
apt update

curl -fsSLo /etc/apt/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
echo "deb [signed-by=/etc/apt/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | tee /etc/apt/sources.list.d/kubernetes.list

apt update
<<output
Hit:1 http://security.ubuntu.com/ubuntu jammy-security InRelease
Hit:2 http://archive.ubuntu.com/ubuntu jammy InRelease
Hit:3 http://archive.ubuntu.com/ubuntu jammy-updates InRelease
Hit:4 http://archive.ubuntu.com/ubuntu jammy-backports InRelease
Get:5 https://packages.cloud.google.com/apt kubernetes-xenial InRelease [9383 B]
Get:6 https://packages.cloud.google.com/apt kubernetes-xenial/main amd64 Packages [62.2 kB]
Fetched 71.6 kB in 1s (76.2 kB/s)
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
17 packages can be upgraded. Run 'apt list --upgradable' to see them.
output

apt install -y apt-transport-https ca-certificates curl
apt install -y kubeadm=1.25.5-00


# step-4: apply planned update
# ----------------------------

kubeadm upgrade apply v1.25.5
<<output
[upgrade/config] Making sure the configuration is correct:
[upgrade/config] Reading configuration from the cluster...
[upgrade/config] FYI: You can look at this config file with 'kubectl -n kube-system get cm kubeadm-config -o yaml'
[preflight] Running pre-flight checks.
[upgrade] Running cluster health checks
[upgrade/version] You have chosen to change the cluster version to "v1.25.5"
[upgrade/versions] Cluster version: v1.25.3
[upgrade/versions] kubeadm version: v1.25.5
[upgrade] Are you sure you want to proceed? [y/N]: y
[upgrade/prepull] Pulling images required for setting up a Kubernetes cluster
[upgrade/prepull] This might take a minute or two, depending on the speed of your internet connection
[upgrade/prepull] You can also perform this action in beforehand using 'kubeadm config images pull'
[upgrade/config] Making sure the configuration is correct:
[upgrade/config] Reading configuration from the cluster...
[upgrade/config] FYI: You can look at this config file with 'kubectl -n kube-system get cm kubeadm-config -o yaml'
[preflight] Running pre-flight checks.
[upgrade] Running cluster health checks
[upgrade/version] You have chosen to change the cluster version to "v1.25.5"
[upgrade/versions] Cluster version: v1.25.3
[upgrade/versions] kubeadm version: v1.25.5
[upgrade] Are you sure you want to proceed? [y/N]: y
[upgrade/prepull] Pulling images required for setting up a Kubernetes cluster
[upgrade/prepull] This might take a minute or two, depending on the speed of your internet connection
[upgrade/prepull] You can also perform this action in beforehand using 'kubeadm config images pull'
[upgrade/staticpods] Waiting for the kubelet to restart the component
[upgrade/staticpods] This might take a minute or longer depending on the component/version gap (timeout 5m0s)
[apiclient] Found 1 Pods for label selector component=kube-scheduler
[upgrade/staticpods] Component "kube-scheduler" upgraded successfully!
[upgrade/postupgrade] Removing the old taint &Taint{Key:node-role.kubernetes.io/master,Value:,Effect:NoSchedule,TimeAdded:<nil>,} from all control plane Nodes. After this step only the &Taint{Key:node-role.kubernetes.io/control-plane,Value:,Effect:NoSchedule,TimeAdded:<nil>,} taint will be present on control plane Nodes.
[upload-config] Storing the configuration used in ConfigMap "kubeadm-config" in the "kube-system" Namespace
[kubelet] Creating a ConfigMap "kubelet-config" in namespace kube-system with the configuration for the kubelets in the cluster
[kubelet-start] Writing kubelet configuration to file "/var/lib/kubelet/config.yaml"
[bootstrap-token] Configured RBAC rules to allow Node Bootstrap tokens to get nodes
[bootstrap-token] Configured RBAC rules to allow Node Bootstrap tokens to post CSRs in order for nodes to get long term certificate credentials
[bootstrap-token] Configured RBAC rules to allow the csrapprover controller automatically approve CSRs from a Node Bootstrap Token
[bootstrap-token] Configured RBAC rules to allow certificate rotation for all node client certificates in the cluster
[addons] Applied essential addon: CoreDNS
[addons] Applied essential addon: kube-proxy

[upgrade/successful] SUCCESS! Your cluster was upgraded to "v1.25.5". Enjoy!
output












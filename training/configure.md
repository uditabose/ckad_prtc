# Install and Configuration

## Table of Content  <!-- omit in toc -->

- [Install and Configuration](#install-and-configuration)
  - [Context](#context)
  - [Create a Gcloud cluster](#create-a-gcloud-cluster)
    - [Results](#results)
  - [kubeadm](#kubeadm)
  - [Upgrade](#upgrade)
  - [Main Deployment Configurations](#main-deployment-configurations)
    - [Single-node](#single-node)
    - [Single head node, multiple workers](#single-head-node-multiple-workers)
    - [Multiple head nodes with HA, multiple workers](#multiple-head-nodes-with-ha-multiple-workers)
    - [HA etcd, HA head nodes, multiple workers](#ha-etcd-ha-head-nodes-multiple-workers)


## Context

A context is a combination of a cluster and user credentials. You can pass these parameters on the command line, or switch the shell between contexts with a command, as in:

```bash
kubectl config use-context foobar
```

```bash
cat ~/.kube/config
```

## Create a Gcloud cluster

```bash
gcloud auth login
gcloud config set project ckad-2024
# create billing account
# associate billing with Kuberenetes Engine
# activate Kubernetes Enging
gcloud container clusters create linuxfoundation --region northamerica-northeast1-a
# gcloud components install gke-gcloud-auth-plugin
# https://cloud.google.com/kubernetes-engine/docs/how-to/cluster-access-for-kubectl#install_plugin
gcloud container clusters list

kubectl get nodes
gcloud container clusters delete linuxfoundation
```

### Results

```bash

gcloud container clusters create linuxfoundation --region northamerica-northeast1-a

Default change: VPC-native is the default mode during cluster creation for versions greater than 1.21.0-gke.1500. To create advanced routes based clusters, please pass the `--no-enable-ip-alias` flag
Note: The Kubelet readonly port (10255) is now deprecated. Please update your workloads to use the recommended alternatives. See https://cloud.google.com/kubernetes-engine/docs/how-to/disable-kubelet-readonly-port for ways to check usage and for migration instructions.
Note: Your Pod address range (`--cluster-ipv4-cidr`) can accommodate at most 1008 node(s).
Creating cluster linuxfoundation in northamerica-northeast1-a... Cluster is being health-checked (master is healthy)...done.
Created [https://container.googleapis.com/v1/projects/ckad-2024/zones/northamerica-northeast1-a/clusters/linuxfoundation].
To inspect the contents of your cluster, go to: https://console.cloud.google.com/kubernetes/workload_/gcloud/northamerica-northeast1-a/linuxfoundation?project=ckad-2024
CRITICAL: ACTION REQUIRED: gke-gcloud-auth-plugin, which is needed for continued use of kubectl, was not found or is not executable. Install gke-gcloud-auth-plugin for use with kubectl by following https://cloud.google.com/kubernetes-engine/docs/how-to/cluster-access-for-kubectl#install_plugin
kubeconfig entry generated for linuxfoundation.
NAME             LOCATION                   MASTER_VERSION      MASTER_IP    MACHINE_TYPE  NODE_VERSION        NUM_NODES  STATUS
linuxfoundation  northamerica-northeast1-a  1.29.6-gke.1038001  34.47.12.41  e2-medium     1.29.6-gke.1038001  3          RUNNING
```

```bash
kubectl get nodes 
NAME                                             STATUS   ROLES    AGE    VERSION
gke-linuxfoundation-default-pool-81927b01-0xqd   Ready    <none>   8m9s   v1.29.6-gke.1038001
gke-linuxfoundation-default-pool-81927b01-sdk1   Ready    <none>   8m8s   v1.29.6-gke.1038001
gke-linuxfoundation-default-pool-81927b01-sgsk   Ready    <none>   8m8s   v1.29.6-gke.1038001
```

```bash
 gcloud container clusters delete linuxfoundation --region northamerica-northeast1-a

The following clusters will be deleted.
 - [linuxfoundation] in [northamerica-northeast1-a]

Do you want to continue (Y/n)?  Y

Deleting cluster linuxfoundation...⠛
```

## kubeadm

- Run `kubeadm init` on the control plane node
- Create a network for IP-per-Pod criteria
- Run `kubeadm join` on workers or secondary cp nodes

## Upgrade

General upgrade process:

- Update the software
- Check the software version
- Drain the control plane
- View the planned upgrade
- Apply the upgrade
- Uncordon the control plane to allow pods to be scheduled

## Main Deployment Configurations

At a high level, you have four main deployment configurations:

### Single-node

With a single-node deployment, all the components run on the same server. This is great for testing, learning, and developing around Kubernetes.

### Single head node, multiple workers

Adding more workers, a single head node and multiple workers typically will consist of a single node etcd instance running on the head node with the API, the scheduler, and the controller-manager.

### Multiple head nodes with HA, multiple workers

Multiple head nodes in an HA configuration and multiple workers add more durability to the cluster. The API server will be fronted by a load balancer, the scheduler and the controller-manager will elect a leader (which is configured via flags). The etcd setup can still be single node.

### HA etcd, HA head nodes, multiple workers

The most advanced and resilient setup would be an HA etcd cluster, with HA head nodes and multiple workers. Also, etcd would run as a true cluster, which would provide HA and would run on nodes separate from the Kubernetes head nodes.

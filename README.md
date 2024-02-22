# ckad_prtc
CKA and CKAD practice

## Exam objectives

1. Cluster architecture, Installation and configuration (25%)
   1. Role-based access control 
   2. Kubeadm to add features and update a Kubernetes cluster
   3. Backing up and restoring the etcd datastore
2. Workloads and scheduling (15%)
   1. Performing rolling updates and rollbacks
   2. Scaling applications
   3. Using ConfigMaps and Secrets
3. Services and networking (20%)
   1. Creating and updating various Services in Kubernetes
   2. Using Ingress, DNS, and the container network interface in Kubernetes
4. Storage (10%)
   1. Understand storage classes, persistent volumes, and volume modes in Kubernetes
5. Troubleshooting (30%)
   1. Logs from a Kubernetes cluster
   2. Monitor and repair core cluster components


### More details
- You will have six clusters available during the exam that you will be required to switch between depending on the question. Usually, each question will ask you to perform the task on a different cluster than the previous question.
- kubectl set to k
- l='ls -lah'


| CLUSTER | NODES                                      | CNI      |
|---------|--------------------------------------------|----------|
| k8s     | 1 control plane, 2 workers                 | Flannel  |
| hk8s    | 1 control plane, 2 workers                 | Calico   |
| bk8s    | 1 control plane, 1 worker                  | Flannel  |
| wk8s    | 1 control plane, 2 workers                 | Flannel  |
| ek8s    | 1 control plane, 2 workers                 | Flannel  |
| ik8s    | 1 control plane, 1 orphaned (missing node) | Loopback |

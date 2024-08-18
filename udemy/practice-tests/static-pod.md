       Welcome to the KodeKloud Hands-On lab                                                                         
    __ ______  ____  ________ __ __    ____  __  ______ 
   / //_/ __ \/ __ \/ ____/ //_// /   / __ \/ / / / __ \
  / ,< / / / / / / / __/ / ,<  / /   / / / / / / / / / /
 / /| / /_/ / /_/ / /___/ /| |/ /___/ /_/ / /_/ / /_/ / 
/_/ |_\____/_____/_____/_/ |_/_____/\____/\____/_____/  
                                                        
            All rights reserved                                                                                      

controlplane ~ ➜  kubectl get pods --all-namespaces -o wide
NAMESPACE      NAME                                   READY   STATUS    RESTARTS   AGE   IP             NODE           NOMINATED NODE   READINESS GATES
kube-flannel   kube-flannel-ds-q9nnz                  1/1     Running   0          10m   192.32.88.12   controlplane   <none>           <none>
kube-flannel   kube-flannel-ds-ww2lp                  1/1     Running   0          10m   192.32.88.3    node01         <none>           <none>
kube-system    coredns-768b85b76f-74m4b               1/1     Running   0          10m   10.244.0.3     controlplane   <none>           <none>
kube-system    coredns-768b85b76f-c5chs               1/1     Running   0          10m   10.244.0.2     controlplane   <none>           <none>
kube-system    etcd-controlplane                      1/1     Running   0          10m   192.32.88.12   controlplane   <none>           <none>
kube-system    kube-apiserver-controlplane            1/1     Running   0          10m   192.32.88.12   controlplane   <none>           <none>
kube-system    kube-controller-manager-controlplane   1/1     Running   0          10m   192.32.88.12   controlplane   <none>           <none>
kube-system    kube-proxy-t6wpp                       1/1     Running   0          10m   192.32.88.12   controlplane   <none>           <none>
kube-system    kube-proxy-v42vp                       1/1     Running   0          10m   192.32.88.3    node01         <none>           <none>
kube-system    kube-scheduler-controlplane            1/1     Running   0          10m   192.32.88.12   controlplane   <none>           <none>

controlplane ~ ➜  kubectl config current-context
kubernetes-admin@kubernetes

controlplane ~ ➜  kubectl config  --help
Modify kubeconfig files using subcommands like "kubectl config set current-context my-context".

 The loading order follows these rules:

  1.  If the --kubeconfig flag is set, then only that file is loaded. The flag may only be set once and no merging takes
place.
  2.  If $KUBECONFIG environment variable is set, then it is used as a list of paths (normal path delimiting rules for
your system). These paths are merged. When a value is modified, it is modified in the file that defines the stanza. When
a value is created, it is created in the first file that exists. If no files in the chain exist, then it creates the
last file in the list.
  3.  Otherwise, ${HOME}/.kube/config is used and no merging takes place.

Available Commands:
  current-context   Display the current-context
  delete-cluster    Delete the specified cluster from the kubeconfig
  delete-context    Delete the specified context from the kubeconfig
  delete-user       Delete the specified user from the kubeconfig
  get-clusters      Display clusters defined in the kubeconfig
  get-contexts      Describe one or many contexts
  get-users         Display users defined in the kubeconfig
  rename-context    Rename a context from the kubeconfig file
  set               Set an individual value in a kubeconfig file
  set-cluster       Set a cluster entry in kubeconfig
  set-context       Set a context entry in kubeconfig
  set-credentials   Set a user entry in kubeconfig
  unset             Unset an individual value in a kubeconfig file
  use-context       Set the current-context in a kubeconfig file
  view              Display merged kubeconfig settings or a specified kubeconfig file

Usage:
  kubectl config SUBCOMMAND [options]

Use "kubectl config <command> --help" for more information about a given command.
Use "kubectl options" for a list of global command-line options (applies to all commands).

controlplane ~ ➜  kubectl config  view
apiVersion: v1
clusters:
- cluster:
    certificate-authority-data: DATA+OMITTED
    server: https://controlplane:6443
  name: kubernetes
contexts:
- context:
    cluster: kubernetes
    user: kubernetes-admin
  name: kubernetes-admin@kubernetes
current-context: kubernetes-admin@kubernetes
kind: Config
preferences: {}
users:
- name: kubernetes-admin
  user:
    client-certificate-data: DATA+OMITTED
    client-key-data: DATA+OMITTED

controlplane ~ ➜  ls -l ~/.kube/
total 12
drwxr-x--- 4 root root 4096 Aug 15 15:45 cache
-rw------- 1 root root 5652 Aug 15 15:35 config

controlplane ~ ➜  ls -l ~/.kube/config 
-rw------- 1 root root 5652 Aug 15 15:35 /root/.kube/config

controlplane ~ ➜  cat ~/.kube/config 
apiVersion: v1
clusters:
- cluster:
    certificate-authority-data: LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSURCVENDQWUyZ0F3SUJBZ0lJZUx3SXMyaUpjQXd3RFFZSktvWklodmNOQVFFTEJRQXdGVEVUTUJFR0ExVUUKQXhNS2EzVmlaWEp1WlhSbGN6QWVGdzB5TkRBNE1UVXhOVE13TXpaYUZ3MHpOREE0TVRNeE5UTTFNelphTUJVeApFekFSQmdOVkJBTVRDbXQxWW1WeWJtVjBaWE13Z2dFaU1BMEdDU3FHU0liM0RRRUJBUVVBQTRJQkR3QXdnZ0VLCkFvSUJBUUM1bEFkMUtTK2dCRi9EOTR5QzZGVDlmVE9BSWF2MXFKQlJKMVdja251ZEwyRWlQZVdYUnlJT2pXeVoKSlo5Mm1IejNwTmsrRWVrVU9XR1Q4dlZ6U2J6T0lOMzNQZDd4alUvcm9keHIyMkpyLzNrTmZaTnNIK3hHeVV5eApFVFBZbWJtbGVud0ttM2Y2SWIzSlBaQUxVUUZOOUtTN29abStQdytpYjZRQ3JtRWh6WHFVZE5YTm5EY3hacjJOClV3bjJPb2tCTnp2am1LbDNPQ3hUYzB3ZnQwVHFBTnIwNXhFRkRsQ3NwdGpVZGlFaFhEN3NMRWxkZGtVV29jekwKcE5uRFY4eHdaSnB6cEg1S0t4dHJVcXBLdXcwZXFCMmtPSkZuVFN5SUtRZlFWZlgyZmE4WllqSXNQU3lDQVZtNAp5SDR1OVF3WlVhYlk3YVk5Z2NNNHU1OEsySWxUQWdNQkFBR2pXVEJYTUE0R0ExVWREd0VCL3dRRUF3SUNwREFQCkJnTlZIUk1CQWY4RUJUQURBUUgvTUIwR0ExVWREZ1FXQkJSN0FwTDhmY2NnQXFzYjRqTTlGNFhvMGxtanhqQVYKQmdOVkhSRUVEakFNZ2dwcmRXSmxjbTVsZEdWek1BMEdDU3FHU0liM0RRRUJDd1VBQTRJQkFRQks4QjMwUURVUwpRUG1UZzEvUDF2WW1qakh2Y0Z1VUJueWNnK3hCTUt5RmVtR2Q4N3JNZllOS3VSMVNGbEsrbnhxWk9yZkVOYW9SCmtTSzNXT2lDbXNBY3dtYWo0NzlMcWdQaS9WWnBHdWRLaEI1ODR1aE5DUVVsQk1senJpaDlWaUhpcGdsbUcwV08KSW1vakZSdC9pV1BmN1A5V2FqUUZ4aWRadTVlUThiYkM4TFNFWDlVN3lxbm92TFlUTWVMUXgxQjJFVFpic1kxeApnekNaTkNBRVNJZjEwZWxXK2NNdzlqR2FKTGloSlhRNG1xa3ByZVJNUTFDNUplRm1zVC84ZStjQUxYdnVMNEtVClN4QlZTYTVSRW5FK3JoM2J2SzNyajVxVTJ2V2swS1VnMU02TjduOGEvS2pRVUczWk5LcWN2aGExTDN5TWpuckYKSy96UXVzMlkzOFZzCi0tLS0tRU5EIENFUlRJRklDQVRFLS0tLS0K
    server: https://controlplane:6443
  name: kubernetes
contexts:
- context:
    cluster: kubernetes
    user: kubernetes-admin
  name: kubernetes-admin@kubernetes
current-context: kubernetes-admin@kubernetes
kind: Config
preferences: {}
users:
- name: kubernetes-admin
  user:
    client-certificate-data: LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSURLVENDQWhHZ0F3SUJBZ0lJTnBzMGloOUxQQ0V3RFFZSktvWklodmNOQVFFTEJRQXdGVEVUTUJFR0ExVUUKQXhNS2EzVmlaWEp1WlhSbGN6QWVGdzB5TkRBNE1UVXhOVE13TXpaYUZ3MHlOVEE0TVRVeE5UTTFNemhhTUR3eApIekFkQmdOVkJBb1RGbXQxWW1WaFpHMDZZMngxYzNSbGNpMWhaRzFwYm5NeEdUQVhCZ05WQkFNVEVHdDFZbVZ5CmJtVjBaWE10WVdSdGFXNHdnZ0VpTUEwR0NTcUdTSWIzRFFFQkFRVUFBNElCRHdBd2dnRUtBb0lCQVFERGpLZ3cKaGFIaHp1VlpBNTlFM0NITXowVmlpd3hDZ1hGT1R0RUN2VXZHa1I3MHhMdUFzQmVIa04yTnNnNElPc2RwaGJIawp2SG9Nb3dUK25naklNRy83N3VQVEdoQ293SVlTZjNOMTQyREZJVXl5WXBLYmhZNGJ4TkFjK2NBbHJnYnNIVkt2CmkvQk5PbTQrM1pqd3JNVHNZYkdpdXRKM2VIcS9MdnRQdTZ3YVowSzdCZktLclIzUmhhbjYwQk0wSnAxckorSHoKT1Y4aWNUdFV2SlZBSzY4YU83MktNUjZXQml4T3ZLLzV0dEduZTlwRUwvY1NEbzg3YWM2SHU5NVZ1Um9XM0JPQwpydDNMRm8ydHkxVGp6cFR2SWRXU2FJLzhKMjhmUklTR1BEVlk2aUdzcENIalhTTm1GL0s1TnlTek5iU01qL3ZLCnp0Z0FsWGxZcUlvN3E2TEhBZ01CQUFHalZqQlVNQTRHQTFVZER3RUIvd1FFQXdJRm9EQVRCZ05WSFNVRUREQUsKQmdnckJnRUZCUWNEQWpBTUJnTlZIUk1CQWY4RUFqQUFNQjhHQTFVZEl3UVlNQmFBRkhzQ2t2eDl4eUFDcXh2aQpNejBYaGVqU1dhUEdNQTBHQ1NxR1NJYjNEUUVCQ3dVQUE0SUJBUUNIU1UwVmJ5eVY1ZE16M0ovNEpkV1llSzZsCk9nTjJQVERUYW9JYSs0WXk1QitYR2g0aGQvQ0pCZ3JTd29BdkNEa0lKRW5EaXVhR3hWR00rU3NlQXpXcGdRUHcKT1o3aDUydDBSQnpocWUzRFRucTZmZjdDYnlZTGlvNk1OUUhSdUtvR053UzFsa0o5TWNXYTVRUEYxRDFSa0dMTwp0bVNuNFNMd3BKanUyN1FCSk0rTGxlS2VlWWc2dmFyOWtWYldjd3h1WVdjbFNpbk9SQmg2dktxaHJaRlcwTHkrCkM3Y0xzajJxcHVWd095dzQ5RlZJSy96WllTdWt2cmNBWDZEejh2SG41bmlFbHdQN05OQVN5b2NFN2RNOVRFUjcKRnZQN2FTbTBsU0o5c2VRcTBHOGJ2S3N0c0d0enQxVXhsNVdNZ1hvSHZKeUhsTkRiT09ycXk0dThrckV5Ci0tLS0tRU5EIENFUlRJRklDQVRFLS0tLS0K
    client-key-data: LS0tLS1CRUdJTiBSU0EgUFJJVkFURSBLRVktLS0tLQpNSUlFb3dJQkFBS0NBUUVBdzR5b01JV2g0YzdsV1FPZlJOd2h6TTlGWW9zTVFvRnhUazdSQXIxTHhwRWU5TVM3CmdMQVhoNURkamJJT0NEckhhWVd4NUx4NkRLTUUvcDRJeURCdisrN2oweG9RcU1DR0VuOXpkZU5neFNGTXNtS1MKbTRXT0c4VFFIUG5BSmE0RzdCMVNyNHZ3VFRwdVB0Mlk4S3pFN0dHeG9yclNkM2g2dnk3N1Q3dXNHbWRDdXdYeQppcTBkMFlXcCt0QVROQ2FkYXlmaDh6bGZJbkU3Vkx5VlFDdXZHanU5aWpFZWxnWXNUcnl2K2JiUnAzdmFSQy8zCkVnNlBPMm5PaDd2ZVZia2FGdHdUZ3E3ZHl4YU5yY3RVNDg2VTd5SFZrbWlQL0NkdkgwU0VoancxV09vaHJLUWgKNDEwalpoZnl1VGNrc3pXMGpJLzd5czdZQUpWNVdLaUtPNnVpeHdJREFRQUJBb0lCQUJ5NzZHTG8zL2FzVGlzYwpTeVQxSzhwS2txbCtRUmpzcUZlWFlVTUR5Y1N0d2x5NUk4d3ZFK1lKdFdTQ3kya09LZ3NwYUJCeVdZVE4xNGdLCmRNUGx5aTY4MWFGSmJUVSt4UFNtNGJKcTdPZEtrMWlLLzN2MnpnRHFsS0lOV055d2k3ZmFQeklvWC9FWkt1WDEKN2VrL21kZ2FLdDM4a2J5WWFZRDZTRmRZL2xzS20ybEgvcjRkbXpFaU9ndWpwSVNSUzdMSUx6aE9lQW43dU9LNAozNlkxeDJBTHZLWjBsQ2RqVERyQWU4RFlzY081SmlNdWZ3MnJlUzhpMTR2YXpwbUYvK01nekI5UmhsVjBsa0M2CnVaZ2R6OUpUdnZ5eTlhcEhOODlLVUxzanpMS0hBZDljbTh5Ymx5U3loOTc1NzlkTENyRmIzOTFOWFRqcE9FaEkKTWhGQTBKRUNnWUVBMEVaeXdMd3NPZG1DNmdaVmQrbUNaVVRrb1pmYXE4blA1VGJuL253MS9rL1l0MU9qN0FabgptenJsa1pWQmVUaFd2bzhpWkZ6dUxRUnRNWEEwNFJxZHNENFJDYi9SdlFZL0VSVklwQ1V0UnRNelE1a3pSZWRaCkpwd3U4SmY3ZVlWcUtMc3EzYUpURWs5eWFYVjlvaXZmNkpwdFdoZXB0TEZnWGNHendSYXArVDBDZ1lFQThGdTEKWVdOcVhiTzAxQnZpVk9TREpHd2dvN2FjOHoyNzVacGF1RWovemFvK2lIZXpyS0krRkJTRE5SelVqVGZUcU9rVwpPNnNkOStyWnhWL0ZxVVZuMUpPYXVxVTB0QjlPelRjaXFYQTVhd2RDNlY1VlpJYVBZbFo1UkFqdHZublFrREd2CjFxVG5UVkc1V2ptRml6Y2l0QkFvMzNMaTdrdGVId0Z2OXYxRVpGTUNnWUFOczBTakp2Mmx4SWdYQ3RtZWJLN1cKS0lUOW1EYWJMRWhQcEovNEhvV1N0Ly9pZDA4R0hKbStIVTZ5bCtYWnFub1NTT29UUGdXdzBtUzRadEFqcXBPSwozMXBSa051a0dvQVZpSmZockV4aEowMXMrZXZrZ2taY0F0UVhvWGU2VTZ0YkNJeldUWEkzZHlCb2pZRDVKUGV5Cm5rM3BLanRRbG9ablJIR2xsdThSWlFLQmdRRFR2M2RqZkxuUUl1bERrKzBvN01lNzVxWTZsRDVnN0JvRWhKODMKaXRnUXo5S1hWeDByRVNPdmZRSzZYOVBCTlZWNmtSM05JMHNiaGdLa0oyTnpaSG04aE96alVYZkUxM0FNeW0zMgo1Njh0NHcvSG1CdVNuQmpsZ1ZrRDN2blR2RzFKR3Z6V0ZDRFJ0UldkcnQ4L2JpdGNobi83bXJMaFMvUjNURVRmClN2QmRrUUtCZ0ZZVWxOb2VycU5TTHpTVmQ5NlpnWFNDN1Z2enhGSHBlU3drU1FHQk5EazJXR2VaMG4wTkdoNmwKcmg2U2thTU5FN2pLVXk1bjJKSkFGNVNobVc1TlNUMWFUZVQwbCtFdytSTjBxZGVPc0hPS2dJRFp0QjNPV2dPeApFNGZrZmVwK2dDWXk4YlZXR1dKS3hjL3BORUwyYk1xdDZYS0V5UFlaQ2c1cjFPTVZ3ODdZCi0tLS0tRU5EIFJTQSBQUklWQVRFIEtFWS0tLS0tCg==

controlplane ~ ➜  docker ps
-bash: docker: command not found

controlplane ~ ✖ ls -l /etc/m
machine-id      manpath.config  mime.types      mke2fs.conf     modprobe.d/     modules         modules-load.d/ mtab            

controlplane ~ ✖ ls -l /etc/k
kernel/     kubernetes/ 

controlplane ~ ✖ ls -l /etc/kubernetes/
total 44
-rw------- 1 root root 5652 Aug 15 15:35 admin.conf
-rw------- 1 root root 5680 Aug 15 15:35 controller-manager.conf
-rw------- 1 root root 1992 Aug 15 15:35 kubelet.conf
drwxrwxr-x 1 root root 4096 Aug 15 15:35 manifests
drwxr-xr-x 3 root root 4096 Aug 15 15:35 pki
-rw------- 1 root root 5624 Aug 15 15:35 scheduler.conf
-rw------- 1 root root 5676 Aug 15 15:35 super-admin.conf

controlplane ~ ➜  ls -l /etc/kubernetes/manifests/
total 16
-rw------- 1 root root 2406 Aug 15 15:35 etcd.yaml
-rw------- 1 root root 3882 Aug 15 15:35 kube-apiserver.yaml
-rw------- 1 root root 3393 Aug 15 15:35 kube-controller-manager.yaml
-rw------- 1 root root 1463 Aug 15 15:35 kube-scheduler.yaml

controlplane ~ ➜  kubectl get pods --all-namespaces -o wide
NAMESPACE      NAME                                   READY   STATUS    RESTARTS   AGE   IP             NODE           NOMINATED NODE   READINESS GATES
kube-flannel   kube-flannel-ds-q9nnz                  1/1     Running   0          48m   192.32.88.12   controlplane   <none>           <none>
kube-flannel   kube-flannel-ds-ww2lp                  1/1     Running   0          47m   192.32.88.3    node01         <none>           <none>
kube-system    coredns-768b85b76f-74m4b               1/1     Running   0          48m   10.244.0.3     controlplane   <none>           <none>
kube-system    coredns-768b85b76f-c5chs               1/1     Running   0          48m   10.244.0.2     controlplane   <none>           <none>
kube-system    etcd-controlplane                      1/1     Running   0          48m   192.32.88.12   controlplane   <none>           <none>
kube-system    kube-apiserver-controlplane            1/1     Running   0          48m   192.32.88.12   controlplane   <none>           <none>
kube-system    kube-controller-manager-controlplane   1/1     Running   0          48m   192.32.88.12   controlplane   <none>           <none>
kube-system    kube-proxy-t6wpp                       1/1     Running   0          48m   192.32.88.12   controlplane   <none>           <none>
kube-system    kube-proxy-v42vp                       1/1     Running   0          47m   192.32.88.3    node01         <none>           <none>
kube-system    kube-scheduler-controlplane            1/1     Running   0          48m   192.32.88.12   controlplane   <none>           <none>

controlplane ~ ➜  cat  /etc/kubernetes/manifests/kube-apiserver.yaml
apiVersion: v1
kind: Pod
metadata:
  annotations:
    kubeadm.kubernetes.io/kube-apiserver.advertise-address.endpoint: 192.32.88.12:6443
  creationTimestamp: null
  labels:
    component: kube-apiserver
    tier: control-plane
  name: kube-apiserver
  namespace: kube-system
spec:
  containers:
  - command:
    - kube-apiserver
    - --advertise-address=192.32.88.12
    - --allow-privileged=true
    - --authorization-mode=Node,RBAC
    - --client-ca-file=/etc/kubernetes/pki/ca.crt
    - --enable-admission-plugins=NodeRestriction
    - --enable-bootstrap-token-auth=true
    - --etcd-cafile=/etc/kubernetes/pki/etcd/ca.crt
    - --etcd-certfile=/etc/kubernetes/pki/apiserver-etcd-client.crt
    - --etcd-keyfile=/etc/kubernetes/pki/apiserver-etcd-client.key
    - --etcd-servers=https://127.0.0.1:2379
    - --kubelet-client-certificate=/etc/kubernetes/pki/apiserver-kubelet-client.crt
    - --kubelet-client-key=/etc/kubernetes/pki/apiserver-kubelet-client.key
    - --kubelet-preferred-address-types=InternalIP,ExternalIP,Hostname
    - --proxy-client-cert-file=/etc/kubernetes/pki/front-proxy-client.crt
    - --proxy-client-key-file=/etc/kubernetes/pki/front-proxy-client.key
    - --requestheader-allowed-names=front-proxy-client
    - --requestheader-client-ca-file=/etc/kubernetes/pki/front-proxy-ca.crt
    - --requestheader-extra-headers-prefix=X-Remote-Extra-
    - --requestheader-group-headers=X-Remote-Group
    - --requestheader-username-headers=X-Remote-User
    - --secure-port=6443
    - --service-account-issuer=https://kubernetes.default.svc.cluster.local
    - --service-account-key-file=/etc/kubernetes/pki/sa.pub
    - --service-account-signing-key-file=/etc/kubernetes/pki/sa.key
    - --service-cluster-ip-range=10.96.0.0/12
    - --tls-cert-file=/etc/kubernetes/pki/apiserver.crt
    - --tls-private-key-file=/etc/kubernetes/pki/apiserver.key
    image: registry.k8s.io/kube-apiserver:v1.30.0
    imagePullPolicy: IfNotPresent
    livenessProbe:
      failureThreshold: 8
      httpGet:
        host: 192.32.88.12
        path: /livez
        port: 6443
        scheme: HTTPS
      initialDelaySeconds: 10
      periodSeconds: 10
      timeoutSeconds: 15
    name: kube-apiserver
    readinessProbe:
      failureThreshold: 3
      httpGet:
        host: 192.32.88.12
        path: /readyz
        port: 6443
        scheme: HTTPS
      periodSeconds: 1
      timeoutSeconds: 15
    resources:
      requests:
        cpu: 250m
    startupProbe:
      failureThreshold: 24
      httpGet:
        host: 192.32.88.12
        path: /livez
        port: 6443
        scheme: HTTPS
      initialDelaySeconds: 10
      periodSeconds: 10
      timeoutSeconds: 15
    volumeMounts:
    - mountPath: /etc/ssl/certs
      name: ca-certs
      readOnly: true
    - mountPath: /etc/ca-certificates
      name: etc-ca-certificates
      readOnly: true
    - mountPath: /etc/kubernetes/pki
      name: k8s-certs
      readOnly: true
    - mountPath: /usr/local/share/ca-certificates
      name: usr-local-share-ca-certificates
      readOnly: true
    - mountPath: /usr/share/ca-certificates
      name: usr-share-ca-certificates
      readOnly: true
  hostNetwork: true
  priority: 2000001000
  priorityClassName: system-node-critical
  securityContext:
    seccompProfile:
      type: RuntimeDefault
  volumes:
  - hostPath:
      path: /etc/ssl/certs
      type: DirectoryOrCreate
    name: ca-certs
  - hostPath:
      path: /etc/ca-certificates
      type: DirectoryOrCreate
    name: etc-ca-certificates
  - hostPath:
      path: /etc/kubernetes/pki
      type: DirectoryOrCreate
    name: k8s-certs
  - hostPath:
      path: /usr/local/share/ca-certificates
      type: DirectoryOrCreate
    name: usr-local-share-ca-certificates
  - hostPath:
      path: /usr/share/ca-certificates
      type: DirectoryOrCreate
    name: usr-share-ca-certificates
status: {}

controlplane ~ ➜  vi /etc/kubernetes/manifests/static-busybox.yaml

controlplane ~ ➜  ls -l /etc/kubernetes/manifests/
total 20
-rw------- 1 root root 2406 Aug 15 15:35 etcd.yaml
-rw------- 1 root root 3882 Aug 15 15:35 kube-apiserver.yaml
-rw------- 1 root root 3393 Aug 15 15:35 kube-controller-manager.yaml
-rw------- 1 root root 1463 Aug 15 15:35 kube-scheduler.yaml
-rw-r--r-- 1 root root  162 Aug 15 16:30 static-busybox.yaml

controlplane ~ ➜  kubectl create -f /etc/kubernetes/manifests/static-busybox.yaml
The Pod "static-busybox" is invalid: spec.containers[0].name: Required value

controlplane ~ ✖ vi /etc/kubernetes/manifests/static-busybox.yaml

controlplane ~ ➜  kubectl get pods --all-namespaces
NAMESPACE      NAME                                   READY   STATUS    RESTARTS   AGE
default        static-busybox-controlplane            1/1     Running   0          24s
kube-flannel   kube-flannel-ds-q9nnz                  1/1     Running   0          55m
kube-flannel   kube-flannel-ds-ww2lp                  1/1     Running   0          55m
kube-system    coredns-768b85b76f-74m4b               1/1     Running   0          55m
kube-system    coredns-768b85b76f-c5chs               1/1     Running   0          55m
kube-system    etcd-controlplane                      1/1     Running   0          56m
kube-system    kube-apiserver-controlplane            1/1     Running   0          56m
kube-system    kube-controller-manager-controlplane   1/1     Running   0          56m
kube-system    kube-proxy-t6wpp                       1/1     Running   0          55m
kube-system    kube-proxy-v42vp                       1/1     Running   0          55m
kube-system    kube-scheduler-controlplane            1/1     Running   0          56m

controlplane ~ ➜  kubectl edit static-busybox-controlplane  
error: the server doesn't have a resource type "static-busybox-controlplane"

controlplane ~ ✖ kubectl edit pod/static-busybox-controlplane  
pod/static-busybox-controlplane edited

controlplane ~ ➜  kubectl edit static-busybox-controlplane  
error: the server doesn't have a resource type "static-busybox-controlplane"

controlplane ~ ✖ kubectl get pods --all-namespaces
NAMESPACE      NAME                                   READY   STATUS    RESTARTS   AGE
default        static-busybox-controlplane            1/1     Running   0          112s
default        static-greenbox-node01                 1/1     Running   0          27s
kube-flannel   kube-flannel-ds-q9nnz                  1/1     Running   0          57m
kube-flannel   kube-flannel-ds-ww2lp                  1/1     Running   0          56m
kube-system    coredns-768b85b76f-74m4b               1/1     Running   0          57m
kube-system    coredns-768b85b76f-c5chs               1/1     Running   0          57m
kube-system    etcd-controlplane                      1/1     Running   0          57m
kube-system    kube-apiserver-controlplane            1/1     Running   0          57m
kube-system    kube-controller-manager-controlplane   1/1     Running   0          57m
kube-system    kube-proxy-t6wpp                       1/1     Running   0          57m
kube-system    kube-proxy-v42vp                       1/1     Running   0          56m
kube-system    kube-scheduler-controlplane            1/1     Running   0          57m

controlplane ~ ➜  kubectl delete pod/static-greenbox-node01     --force --grace-period=0
Warning: Immediate deletion does not wait for confirmation that the running resource has been terminated. The resource may continue to run on the cluster indefinitely.
pod "static-greenbox-node01" force deleted

controlplane ~ ➜  kubectl get pods --all-namespaces
NAMESPACE      NAME                                   READY   STATUS    RESTARTS   AGE
default        static-busybox-controlplane            1/1     Running   0          2m23s
kube-flannel   kube-flannel-ds-q9nnz                  1/1     Running   0          57m
kube-flannel   kube-flannel-ds-ww2lp                  1/1     Running   0          57m
kube-system    coredns-768b85b76f-74m4b               1/1     Running   0          57m
kube-system    coredns-768b85b76f-c5chs               1/1     Running   0          57m
kube-system    etcd-controlplane                      1/1     Running   0          58m
kube-system    kube-apiserver-controlplane            1/1     Running   0          58m
kube-system    kube-controller-manager-controlplane   1/1     Running   0          58m
kube-system    kube-proxy-t6wpp                       1/1     Running   0          57m
kube-system    kube-proxy-v42vp                       1/1     Running   0          57m
kube-system    kube-scheduler-controlplane            1/1     Running   0          58m

controlplane ~ ➜  kubectl get pods --all-namespaces
NAMESPACE      NAME                                   READY   STATUS    RESTARTS   AGE
default        static-busybox-controlplane            1/1     Running   0          2m28s
kube-flannel   kube-flannel-ds-q9nnz                  1/1     Running   0          58m
kube-flannel   kube-flannel-ds-ww2lp                  1/1     Running   0          57m
kube-system    coredns-768b85b76f-74m4b               1/1     Running   0          58m
kube-system    coredns-768b85b76f-c5chs               1/1     Running   0          58m
kube-system    etcd-controlplane                      1/1     Running   0          58m
kube-system    kube-apiserver-controlplane            1/1     Running   0          58m
kube-system    kube-controller-manager-controlplane   1/1     Running   0          58m
kube-system    kube-proxy-t6wpp                       1/1     Running   0          58m
kube-system    kube-proxy-v42vp                       1/1     Running   0          57m
kube-system    kube-scheduler-controlplane            1/1     Running   0          58m

controlplane ~ ➜  

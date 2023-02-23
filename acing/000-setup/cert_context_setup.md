## Certificate set-up

```bash
 ls -l /etc/kubernetes/
total 36
-rw------- 1 root root 5627 Feb 22 03:18 admin.conf
-rw------- 1 root root 5650 Feb 22 03:18 controller-manager.conf
-rw------- 1 root root 1999 Feb 22 03:18 kubelet.conf
drwxr-xr-x 1 root root 4096 Feb 22 03:18 manifests
drwxr-xr-x 3 root root 4096 Feb 22 03:18 pki
-rw------- 1 root root 5594 Feb 22 03:18 scheduler.conf
```

```bash
 curl -k  https://acing-control-plane:6443
{
  "kind": "Status",
  "apiVersion": "v1",
  "metadata": {},
  "status": "Failure",
  "message": "forbidden: User \"system:anonymous\" cannot get path \"/\"",
  "reason": "Forbidden",
  "details": {},
  "code": 403
}
```

```bash
mkdir ~/.kube
cp /etc/kubernetes/admin.conf ~/.kube/config

 kubectl config view --minify
apiVersion: v1
clusters:
- cluster:
    certificate-authority-data: DATA+OMITTED
    server: https://acing-control-plane:6443
  name: acing
contexts:
- context:
    cluster: acing
    user: kubernetes-admin
  name: kubernetes-admin@acing
current-context: kubernetes-admin@acing
kind: Config
preferences: {}
users:
- name: kubernetes-admin
  user:
    client-certificate-data: REDACTED
    client-key-data: REDACTED
```

       Welcome to the KodeKloud Hands-On lab                                                                         
    __ ______  ____  ________ __ __    ____  __  ______ 
   / //_/ __ \/ __ \/ ____/ //_// /   / __ \/ / / / __ \
  / ,< / / / / / / / __/ / ,<  / /   / / / / / / / / / /
 / /| / /_/ / /_/ / /___/ /| |/ /___/ /_/ / /_/ / /_/ / 
/_/ |_\____/_____/_____/_/ |_/_____/\____/\____/_____/  
                                                        
            All rights reserved                                                                                      

controlplane ~ ➜  kubectl get pods --all-namespaces
NAMESPACE     NAME                                      READY   STATUS      RESTARTS   AGE
kube-system   coredns-576bfc4dc7-tvp4f                  1/1     Running     0          24m
kube-system   local-path-provisioner-75bb9ff978-mt27j   1/1     Running     0          24m
kube-system   helm-install-traefik-crd-5mfr6            0/1     Completed   0          24m
kube-system   svclb-traefik-944c786e-cn7wr              2/2     Running     0          24m
kube-system   helm-install-traefik-4mh9q                0/1     Completed   1          24m
kube-system   traefik-5fb479b77-hl77l                   1/1     Running     0          24m
kube-system   metrics-server-557ff575fb-7knl2           1/1     Running     0          24m
default       app-1-77t7t                               1/1     Running     0          3m18s
default       app-1-b2gft                               1/1     Running     0          3m18s
default       db-1-797r6                                1/1     Running     0          3m17s
default       app-2-gdtzm                               1/1     Running     0          3m18s
default       db-2-xznjf                                1/1     Running     0          3m17s
default       auth                                      1/1     Running     0          3m17s
default       app-1-p8wbd                               1/1     Running     0          3m18s
default       db-1-qhsr8                                1/1     Running     0          3m17s
default       db-1-mjr5s                                1/1     Running     0          3m17s
default       app-1-zzxdf                               1/1     Running     0          3m16s
default       db-1-57dl2                                1/1     Running     0          3m17s

controlplane ~ ➜  kubectl get pods --all-namespaces -o wide
NAMESPACE     NAME                                      READY   STATUS      RESTARTS   AGE     IP           NODE           NOMINATED NODE   READINESS GATES
kube-system   coredns-576bfc4dc7-tvp4f                  1/1     Running     0          24m     10.42.0.4    controlplane   <none>           <none>
kube-system   local-path-provisioner-75bb9ff978-mt27j   1/1     Running     0          24m     10.42.0.2    controlplane   <none>           <none>
kube-system   helm-install-traefik-crd-5mfr6            0/1     Completed   0          24m     10.42.0.5    controlplane   <none>           <none>
kube-system   svclb-traefik-944c786e-cn7wr              2/2     Running     0          24m     10.42.0.7    controlplane   <none>           <none>
kube-system   helm-install-traefik-4mh9q                0/1     Completed   1          24m     10.42.0.6    controlplane   <none>           <none>
kube-system   traefik-5fb479b77-hl77l                   1/1     Running     0          24m     10.42.0.8    controlplane   <none>           <none>
kube-system   metrics-server-557ff575fb-7knl2           1/1     Running     0          24m     10.42.0.3    controlplane   <none>           <none>
default       app-1-77t7t                               1/1     Running     0          3m25s   10.42.0.9    controlplane   <none>           <none>
default       app-1-b2gft                               1/1     Running     0          3m25s   10.42.0.10   controlplane   <none>           <none>
default       db-1-797r6                                1/1     Running     0          3m24s   10.42.0.14   controlplane   <none>           <none>
default       app-2-gdtzm                               1/1     Running     0          3m25s   10.42.0.12   controlplane   <none>           <none>
default       db-2-xznjf                                1/1     Running     0          3m24s   10.42.0.17   controlplane   <none>           <none>
default       auth                                      1/1     Running     0          3m24s   10.42.0.18   controlplane   <none>           <none>
default       app-1-p8wbd                               1/1     Running     0          3m25s   10.42.0.11   controlplane   <none>           <none>
default       db-1-qhsr8                                1/1     Running     0          3m24s   10.42.0.15   controlplane   <none>           <none>
default       db-1-mjr5s                                1/1     Running     0          3m24s   10.42.0.13   controlplane   <none>           <none>
default       app-1-zzxdf                               1/1     Running     0          3m23s   10.42.0.19   controlplane   <none>           <none>
default       db-1-57dl2                                1/1     Running     0          3m24s   10.42.0.16   controlplane   <none>           <none>

controlplane ~ ➜  kubectl get pods --all-namespaces -o wide --show-labels
NAMESPACE     NAME                                      READY   STATUS      RESTARTS   AGE    IP           NODE           NOMINATED NODE   READINESS GATES   LABELS
kube-system   coredns-576bfc4dc7-tvp4f                  1/1     Running     0          27m    10.42.0.4    controlplane   <none>           <none>            k8s-app=kube-dns,pod-template-hash=576bfc4dc7
kube-system   local-path-provisioner-75bb9ff978-mt27j   1/1     Running     0          27m    10.42.0.2    controlplane   <none>           <none>            app=local-path-provisioner,pod-template-hash=75bb9ff978
kube-system   helm-install-traefik-crd-5mfr6            0/1     Completed   0          27m    10.42.0.5    controlplane   <none>           <none>            batch.kubernetes.io/controller-uid=c9dbf862-72d6-4467-96a2-c5f7364e59da,batch.kubernetes.io/job-name=helm-install-traefik-crd,controller-uid=c9dbf862-72d6-4467-96a2-c5f7364e59da,helmcharts.helm.cattle.io/chart=traefik-crd,job-name=helm-install-traefik-crd
kube-system   svclb-traefik-944c786e-cn7wr              2/2     Running     0          27m    10.42.0.7    controlplane   <none>           <none>            app=svclb-traefik-944c786e,controller-revision-hash=549978b98b,pod-template-generation=1,svccontroller.k3s.cattle.io/svcname=traefik,svccontroller.k3s.cattle.io/svcnamespace=kube-system
kube-system   helm-install-traefik-4mh9q                0/1     Completed   1          27m    10.42.0.6    controlplane   <none>           <none>            batch.kubernetes.io/controller-uid=67108b30-0a86-4d75-82b8-c6ce6085f623,batch.kubernetes.io/job-name=helm-install-traefik,controller-uid=67108b30-0a86-4d75-82b8-c6ce6085f623,helmcharts.helm.cattle.io/chart=traefik,job-name=helm-install-traefik
kube-system   traefik-5fb479b77-hl77l                   1/1     Running     0          27m    10.42.0.8    controlplane   <none>           <none>            app.kubernetes.io/instance=traefik-kube-system,app.kubernetes.io/managed-by=Helm,app.kubernetes.io/name=traefik,helm.sh/chart=traefik-25.0.3_up25.0.0,pod-template-hash=5fb479b77
kube-system   metrics-server-557ff575fb-7knl2           1/1     Running     0          27m    10.42.0.3    controlplane   <none>           <none>            k8s-app=metrics-server,pod-template-hash=557ff575fb
default       app-1-77t7t                               1/1     Running     0          6m5s   10.42.0.9    controlplane   <none>           <none>            bu=finance,env=dev,tier=frontend
default       app-1-b2gft                               1/1     Running     0          6m5s   10.42.0.10   controlplane   <none>           <none>            bu=finance,env=dev,tier=frontend
default       db-1-797r6                                1/1     Running     0          6m4s   10.42.0.14   controlplane   <none>           <none>            env=dev,tier=db
default       app-2-gdtzm                               1/1     Running     0          6m5s   10.42.0.12   controlplane   <none>           <none>            env=prod,tier=frontend
default       db-2-xznjf                                1/1     Running     0          6m4s   10.42.0.17   controlplane   <none>           <none>            bu=finance,env=prod,tier=db
default       auth                                      1/1     Running     0          6m4s   10.42.0.18   controlplane   <none>           <none>            bu=finance,env=prod
default       app-1-p8wbd                               1/1     Running     0          6m5s   10.42.0.11   controlplane   <none>           <none>            bu=finance,env=dev,tier=frontend
default       db-1-qhsr8                                1/1     Running     0          6m4s   10.42.0.15   controlplane   <none>           <none>            env=dev,tier=db
default       db-1-mjr5s                                1/1     Running     0          6m4s   10.42.0.13   controlplane   <none>           <none>            env=dev,tier=db
default       app-1-zzxdf                               1/1     Running     0          6m3s   10.42.0.19   controlplane   <none>           <none>            bu=finance,env=prod,tier=frontend
default       db-1-57dl2                                1/1     Running     0          6m4s   10.42.0.16   controlplane   <none>           <none>            env=dev,tier=db

controlplane ~ ➜  kubectl get pods --all-namespaces -o wide --show-labels | grep env
default       app-1-77t7t                               1/1     Running     0          6m27s   10.42.0.9    controlplane   <none>           <none>            bu=finance,env=dev,tier=frontend
default       app-1-b2gft                               1/1     Running     0          6m27s   10.42.0.10   controlplane   <none>           <none>            bu=finance,env=dev,tier=frontend
default       db-1-797r6                                1/1     Running     0          6m26s   10.42.0.14   controlplane   <none>           <none>            env=dev,tier=db
default       app-2-gdtzm                               1/1     Running     0          6m27s   10.42.0.12   controlplane   <none>           <none>            env=prod,tier=frontend
default       db-2-xznjf                                1/1     Running     0          6m26s   10.42.0.17   controlplane   <none>           <none>            bu=finance,env=prod,tier=db
default       auth                                      1/1     Running     0          6m26s   10.42.0.18   controlplane   <none>           <none>            bu=finance,env=prod
default       app-1-p8wbd                               1/1     Running     0          6m27s   10.42.0.11   controlplane   <none>           <none>            bu=finance,env=dev,tier=frontend
default       db-1-qhsr8                                1/1     Running     0          6m26s   10.42.0.15   controlplane   <none>           <none>            env=dev,tier=db
default       db-1-mjr5s                                1/1     Running     0          6m26s   10.42.0.13   controlplane   <none>           <none>            env=dev,tier=db
default       app-1-zzxdf                               1/1     Running     0          6m25s   10.42.0.19   controlplane   <none>           <none>            bu=finance,env=prod,tier=frontend
default       db-1-57dl2                                1/1     Running     0          6m26s   10.42.0.16   controlplane   <none>           <none>            env=dev,tier=db

controlplane ~ ➜  kubectl get pods --all-namespaces -o wide --show-labels | grep env=dev
default       app-1-77t7t                               1/1     Running     0          6m39s   10.42.0.9    controlplane   <none>           <none>            bu=finance,env=dev,tier=frontend
default       app-1-b2gft                               1/1     Running     0          6m39s   10.42.0.10   controlplane   <none>           <none>            bu=finance,env=dev,tier=frontend
default       db-1-797r6                                1/1     Running     0          6m38s   10.42.0.14   controlplane   <none>           <none>            env=dev,tier=db
default       app-1-p8wbd                               1/1     Running     0          6m39s   10.42.0.11   controlplane   <none>           <none>            bu=finance,env=dev,tier=frontend
default       db-1-qhsr8                                1/1     Running     0          6m38s   10.42.0.15   controlplane   <none>           <none>            env=dev,tier=db
default       db-1-mjr5s                                1/1     Running     0          6m38s   10.42.0.13   controlplane   <none>           <none>            env=dev,tier=db
default       db-1-57dl2                                1/1     Running     0          6m38s   10.42.0.16   controlplane   <none>           <none>            env=dev,tier=db

controlplane ~ ➜  kubectl get pods --all-namespaces -o wide --show-labels | grep bu=finance
default       app-1-77t7t                               1/1     Running     0          7m17s   10.42.0.9    controlplane   <none>           <none>            bu=finance,env=dev,tier=frontend
default       app-1-b2gft                               1/1     Running     0          7m17s   10.42.0.10   controlplane   <none>           <none>            bu=finance,env=dev,tier=frontend
default       db-2-xznjf                                1/1     Running     0          7m16s   10.42.0.17   controlplane   <none>           <none>            bu=finance,env=prod,tier=db
default       auth                                      1/1     Running     0          7m16s   10.42.0.18   controlplane   <none>           <none>            bu=finance,env=prod
default       app-1-p8wbd                               1/1     Running     0          7m17s   10.42.0.11   controlplane   <none>           <none>            bu=finance,env=dev,tier=frontend
default       app-1-zzxdf                               1/1     Running     0          7m15s   10.42.0.19   controlplane   <none>           <none>            bu=finance,env=prod,tier=frontend

controlplane ~ ➜  kubectl get pods --all-namespaces -o wide --show-labels | grep env=prod
default       app-2-gdtzm                               1/1     Running     0          7m42s   10.42.0.12   controlplane   <none>           <none>            env=prod,tier=frontend
default       db-2-xznjf                                1/1     Running     0          7m41s   10.42.0.17   controlplane   <none>           <none>            bu=finance,env=prod,tier=db
default       auth                                      1/1     Running     0          7m41s   10.42.0.18   controlplane   <none>           <none>            bu=finance,env=prod
default       app-1-zzxdf                               1/1     Running     0          7m40s   10.42.0.19   controlplane   <none>           <none>            bu=finance,env=prod,tier=frontend

controlplane ~ ➜  kubectl get replicasets --all-namespaces -o wide --show-labels | grep env=prod
default       app-2                               1         1         1       8m8s   busybox                  busybox                                   !bu,env=prod,tier=frontend                                                                                  env=prod
default       db-2                                1         1         1       8m7s   busybox                  busybox                                   env=prod,tier=db                                                                                            env=prod

controlplane ~ ➜  kubectl get replicasets --all-namespaces -o wide --show-labels | grep env=prod | grep bu=finance | grep tier=frontend

controlplane ~ ✖ kubectl get replicasets --all-namespaces -o wide --show-labels | grep env=prod | grep bu=finance | 
> ^C

controlplane ~ ✖ kubectl get replicasets --all-namespaces -o wide --show-labels | grep env=prod | grep bu=finance

controlplane ~ ✖ kubectl get replicasets --all-namespaces -o wide --show-labels | grep env=prod
default       app-2                               1         1         1       9m27s   busybox                  busybox                                   !bu,env=prod,tier=frontend                                                                                  env=prod
default       db-2                                1         1         1       9m26s   busybox                  busybox                                   env=prod,tier=db                                                                                            env=prod

controlplane ~ ➜  kubectl get pods --all-namespaces -o wide --show-labels | grep env=prod
default       app-2-gdtzm                               1/1     Running     0          9m52s   10.42.0.12   controlplane   <none>           <none>            env=prod,tier=frontend
default       db-2-xznjf                                1/1     Running     0          9m51s   10.42.0.17   controlplane   <none>           <none>            bu=finance,env=prod,tier=db
default       auth                                      1/1     Running     0          9m51s   10.42.0.18   controlplane   <none>           <none>            bu=finance,env=prod
default       app-1-zzxdf                               1/1     Running     0          9m50s   10.42.0.19   controlplane   <none>           <none>            bu=finance,env=prod,tier=frontend

controlplane ~ ➜  vi replicaset-definition-1.yaml  

controlplane ~ ➜  vi replicaset-definition-1.yaml  

controlplane ~ ➜  kubectl create -f replicaset-definition-1.yaml  
replicaset.apps/replicaset-1 created

controlplane ~ ➜  

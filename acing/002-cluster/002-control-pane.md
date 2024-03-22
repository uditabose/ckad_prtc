 
 
 `kubectl get po -o wide -A --field-selector spec.nodeName=acing-multi-control-plane`

 ```bash
NAMESPACE            NAME                                                READY   STATUS    RESTARTS   AGE     IP           NODE                        NOMINATED NODE   READINESS GATES
kube-system          coredns-76f75df574-gqjd8                            1/1     Running   0          4d23h   10.244.0.4   acing-multi-control-plane   <none>           <none>
kube-system          coredns-76f75df574-wdxsg                            1/1     Running   0          4d23h   10.244.0.3   acing-multi-control-plane   <none>           <none>
kube-system          etcd-acing-multi-control-plane                      1/1     Running   0          4d23h   172.18.0.7   acing-multi-control-plane   <none>           <none>
kube-system          kindnet-wrf9n                                       1/1     Running   0          4d23h   172.18.0.7   acing-multi-control-plane   <none>           <none>
kube-system          kube-apiserver-acing-multi-control-plane            1/1     Running   0          4d23h   172.18.0.7   acing-multi-control-plane   <none>           <none>
kube-system          kube-controller-manager-acing-multi-control-plane   1/1     Running   0          4d23h   172.18.0.7   acing-multi-control-plane   <none>           <none>
kube-system          kube-proxy-fhrfz                                    1/1     Running   0          4d23h   172.18.0.7   acing-multi-control-plane   <none>           <none>
kube-system          kube-scheduler-acing-multi-control-plane            1/1     Running   0          4d23h   172.18.0.7   acing-multi-control-plane   <none>           <none>
local-path-storage   local-path-provisioner-7577fdbbfb-6plsj             1/1     Running   0          4d23h   10.244.0.2   acing-multi-control-plane   <none>           <none>
 ```
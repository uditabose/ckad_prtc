       Welcome to the KodeKloud Hands-On lab                                                                         
    __ ______  ____  ________ __ __    ____  __  ______ 
   / //_/ __ \/ __ \/ ____/ //_// /   / __ \/ / / / __ \
  / ,< / / / / / / / __/ / ,<  / /   / / / / / / / / / /
 / /| / /_/ / /_/ / /___/ /| |/ /___/ /_/ / /_/ / /_/ / 
/_/ |_\____/_____/_____/_/ |_/_____/\____/\____/_____/  
                                                        
            All rights reserved                                                                                      

controlplane ~ ➜  kubectl top node
NAME           CPU(cores)   CPU%   MEMORY(bytes)   MEMORY%   
controlplane   207m         0%     1122Mi          0%        
node01         26m          0%     291Mi           0%        

controlplane ~ ➜  kubectl top pods
NAME       CPU(cores)   MEMORY(bytes)   
elephant   14m          32Mi            
lion       1m           18Mi            
rabbit     98m          252Mi           

controlplane ~ ➜  kubectl top pods --all-namespaces
NAMESPACE      NAME                                   CPU(cores)   MEMORY(bytes)   
default        elephant                               14m          32Mi            
default        lion                                   1m           18Mi            
default        rabbit                                 98m          252Mi           
kube-flannel   kube-flannel-ds-6gn9v                  7m           33Mi            
kube-flannel   kube-flannel-ds-psggm                  7m           33Mi            
kube-system    coredns-768b85b76f-47xnq               2m           19Mi            
kube-system    coredns-768b85b76f-vnppk               2m           18Mi            
kube-system    etcd-controlplane                      20m          48Mi            
kube-system    kube-apiserver-controlplane            50m          196Mi           
kube-system    kube-controller-manager-controlplane   18m          52Mi            
kube-system    kube-proxy-8xkcq                       1m           32Mi            
kube-system    kube-proxy-vvbt2                       1m           33Mi            
kube-system    kube-scheduler-controlplane            4m           22Mi            
kube-system    metrics-server-6d76cb6848-pc7qr        2m           20Mi            

controlplane ~ ➜  kubectl top pods 
NAME       CPU(cores)   MEMORY(bytes)   
elephant   15m          32Mi            
lion       1m           18Mi            
rabbit     103m         252Mi           

controlplane ~ ➜  kubectl top pods 
NAME       CPU(cores)   MEMORY(bytes)   
elephant   14m          32Mi            
lion       1m           18Mi            
rabbit     98m          252Mi           

controlplane ~ ➜  

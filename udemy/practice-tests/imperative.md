 Welcome to the KodeKloud Hands-On lab                                                                         
    __ ______  ____  ________ __ __    ____  __  ______ 
   / //_/ __ \/ __ \/ ____/ //_// /   / __ \/ / / / __ \
  / ,< / / / / / / / __/ / ,<  / /   / / / / / / / / / /
 / /| / /_/ / /_/ / /___/ /| |/ /___/ /_/ / /_/ / /_/ / 
/_/ |_\____/_____/_____/_/ |_/_____/\____/\____/_____/  
                                                        
            All rights reserved                                                                                      

controlplane ~ ➜  kubectl run nginx-pod --image=nginx:alpine
pod/nginx-pod created

controlplane ~ ➜  kubectl run redis  --image=redis:alpine
pod/redis created

controlplane ~ ➜  kubect edit pod/redis
-bash: kubect: command not found

controlplane ~ ✖ kubectl edit pod/redis
pod/redis edited

controlplane ~ ➜  kubectl describe pod/redis
Name:             redis
Namespace:        default
Priority:         0
Service Account:  default
Node:             controlplane/192.41.18.9
Start Time:       Wed, 14 Aug 2024 20:09:31 +0000
Labels:           run=redis
                  tier=db
Annotations:      <none>
Status:           Running
IP:               10.42.0.10
IPs:
  IP:  10.42.0.10
Containers:
  redis:
    Container ID:   containerd://c1797bb58706feb4174d0ca3141becca8f1e4fbff394fd9a70f0ba5d88e5c757
    Image:          redis:alpine
    Image ID:       docker.io/library/redis@sha256:eaea8264f74a95ea9a0767c794da50788cbd9cf5223951674d491fa1b3f4f2d2
    Port:           <none>
    Host Port:      <none>
    State:          Running
      Started:      Wed, 14 Aug 2024 20:09:37 +0000
    Ready:          True
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-8pz6s (ro)
Conditions:
  Type                        Status
  PodReadyToStartContainers   True 
  Initialized                 True 
  Ready                       True 
  ContainersReady             True 
  PodScheduled                True 
Volumes:
  kube-api-access-8pz6s:
    Type:                    Projected (a volume that contains injected data from multiple sources)
    TokenExpirationSeconds:  3607
    ConfigMapName:           kube-root-ca.crt
    ConfigMapOptional:       <nil>
    DownwardAPI:             true
QoS Class:                   BestEffort
Node-Selectors:              <none>
Tolerations:                 node.kubernetes.io/not-ready:NoExecute op=Exists for 300s
                             node.kubernetes.io/unreachable:NoExecute op=Exists for 300s
Events:
  Type    Reason     Age   From               Message
  ----    ------     ----  ----               -------
  Normal  Scheduled  67s   default-scheduler  Successfully assigned default/redis to controlplane
  Normal  Pulling    67s   kubelet            Pulling image "redis:alpine"
  Normal  Pulled     62s   kubelet            Successfully pulled image "redis:alpine" in 4.514s (4.514s including waiting). Image size: 17173585 bytes.
  Normal  Created    62s   kubelet            Created container redis
  Normal  Started    62s   kubelet            Started container redis

controlplane ~ ➜  kubectl create service clusterip redis-service --tcp=6379:6379 
service/redis-service created

controlplane ~ ➜  kubectl create deployment webapp --image=kodekloud/webapp-color
deployment.apps/webapp created

controlplane ~ ➜  kubectl edit deployment.apps/webapp
deployment.apps/webapp edited

controlplane ~ ➜  kubectl get deployment.apps/webapp
NAME     READY   UP-TO-DATE   AVAILABLE   AGE
webapp   3/3     3            3           29s

controlplane ~ ➜  kubectl run custom-nginx --image=nginx 
pod/custom-nginx created

controlplane ~ ➜  kubectl edit pod/custom-nginx 
error: pods "custom-nginx" is invalid
A copy of your changes has been stored to "/tmp/kubectl-edit-347106469.yaml"
error: Edit cancelled, no valid changes were saved.

controlplane ~ ✖ kubectl get pod/custom-nginx -o wide
NAME           READY   STATUS    RESTARTS   AGE     IP           NODE           NOMINATED NODE   READINESS GATES
custom-nginx   1/1     Running   0          3m13s   10.42.0.14   controlplane   <none>           <none>

controlplane ~ ➜  kubectl delete pod/custom-nginx --forrce --grace-period=0
error: unknown flag: --forrce
See 'kubectl delete --help' for usage.

controlplane ~ ✖ kubectl delete pod/custom-nginx --force --grace-period=0
Warning: Immediate deletion does not wait for confirmation that the running resource has been terminated. The resource may continue to run on the cluster indefinitely.
pod "custom-nginx" force deleted

controlplane ~ ➜  kubectl run custom-nginx --image=nginx --restart=Never --port=8080 --expose
service/custom-nginx created
pod/custom-nginx created

controlplane ~ ➜  kubectl get service/custom-nginx -o json
{
    "apiVersion": "v1",
    "kind": "Service",
    "metadata": {
        "creationTimestamp": "2024-08-14T20:22:13Z",
        "name": "custom-nginx",
        "namespace": "default",
        "resourceVersion": "1160",
        "uid": "a5e548cc-e904-48e8-8852-fde143157fc0"
    },
    "spec": {
        "clusterIP": "10.43.26.95",
        "clusterIPs": [
            "10.43.26.95"
        ],
        "internalTrafficPolicy": "Cluster",
        "ipFamilies": [
            "IPv4"
        ],
        "ipFamilyPolicy": "SingleStack",
        "ports": [
            {
                "port": 8080,
                "protocol": "TCP",
                "targetPort": 8080
            }
        ],
        "selector": {
            "run": "custom-nginx"
        },
        "sessionAffinity": "None",
        "type": "ClusterIP"
    },
    "status": {
        "loadBalancer": {}
    }
}

controlplane ~ ➜  kubectl create namespace dev-ns
namespace/dev-ns created

controlplane ~ ➜  kubectl create deployment redis-deploy --image=redis --namespace=dev-ns
deployment.apps/redis-deploy created

controlplane ~ ➜  kubectl edit deployment.apps/redis-deploy
Error from server (NotFound): deployments.apps "redis-deploy" not found

controlplane ~ ✖ kubectl edit deployment.apps/redis-deploy --namespace=dev-ns
deployment.apps/redis-deploy edited

controlplane ~ ➜  kubectl get  deployment.apps/redis-deploy --namespace=dev-ns
NAME           READY   UP-TO-DATE   AVAILABLE   AGE
redis-deploy   2/2     2            2           46s

controlplane ~ ➜  kubectl get  deployment.apps/redis-deploy --namespace=dev-ns -o json
{
    "apiVersion": "apps/v1",
    "kind": "Deployment",
    "metadata": {
        "annotations": {
            "deployment.kubernetes.io/revision": "1"
        },
        "creationTimestamp": "2024-08-14T20:24:07Z",
        "generation": 2,
        "labels": {
            "app": "redis-deploy"
        },
        "name": "redis-deploy",
        "namespace": "dev-ns",
        "resourceVersion": "1258",
        "uid": "c8447155-3f3a-42ce-9ad1-ce7aa949bd3a"
    },
    "spec": {
        "progressDeadlineSeconds": 600,
        "replicas": 2,
        "revisionHistoryLimit": 10,
        "selector": {
            "matchLabels": {
                "app": "redis-deploy"
            }
        },
        "strategy": {
            "rollingUpdate": {
                "maxSurge": "25%",
                "maxUnavailable": "25%"
            },
            "type": "RollingUpdate"
        },
        "template": {
            "metadata": {
                "creationTimestamp": null,
                "labels": {
                    "app": "redis-deploy"
                }
            },
            "spec": {
                "containers": [
                    {
                        "image": "redis",
                        "imagePullPolicy": "Always",
                        "name": "redis",
                        "resources": {},
                        "terminationMessagePath": "/dev/termination-log",
                        "terminationMessagePolicy": "File"
                    }
                ],
                "dnsPolicy": "ClusterFirst",
                "restartPolicy": "Always",
                "schedulerName": "default-scheduler",
                "securityContext": {},
                "terminationGracePeriodSeconds": 30
            }
        }
    },
    "status": {
        "availableReplicas": 2,
        "conditions": [
            {
                "lastTransitionTime": "2024-08-14T20:24:07Z",
                "lastUpdateTime": "2024-08-14T20:24:13Z",
                "message": "ReplicaSet \"redis-deploy-546bf56c5f\" has successfully progressed.",
                "reason": "NewReplicaSetAvailable",
                "status": "True",
                "type": "Progressing"
            },
            {
                "lastTransitionTime": "2024-08-14T20:24:42Z",
                "lastUpdateTime": "2024-08-14T20:24:42Z",
                "message": "Deployment has minimum availability.",
                "reason": "MinimumReplicasAvailable",
                "status": "True",
                "type": "Available"
            }
        ],
        "observedGeneration": 2,
        "readyReplicas": 2,
        "replicas": 2,
        "updatedReplicas": 2
    }
}

controlplane ~ ➜  kubectl run httpd --image=httpd:alpine 
pod/httpd created

controlplane ~ ➜  kubectl create service clusterip httpd --port=80:80
error: unknown flag: --port
See 'kubectl create service clusterip --help' for usage.

controlplane ~ ✖ 

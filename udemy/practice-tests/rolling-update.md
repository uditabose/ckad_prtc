       Welcome to the KodeKloud Hands-On lab                                                                         
    __ ______  ____  ________ __ __    ____  __  ______ 
   / //_/ __ \/ __ \/ ____/ //_// /   / __ \/ / / / __ \
  / ,< / / / / / / / __/ / ,<  / /   / / / / / / / / / /
 / /| / /_/ / /_/ / /___/ /| |/ /___/ /_/ / /_/ / /_/ / 
/_/ |_\____/_____/_____/_/ |_/_____/\____/\____/_____/  
                                                        
            All rights reserved                                                                                      

controlplane ~ ➜  cat /root/curl-test.sh
for i in {1..35}; do
   kubectl exec --namespace=kube-public curl -- sh -c 'test=`wget -qO- -T 2  http://webapp-service.default.svc.cluster.local:8080/info 2>&1` && echo "$test OK" || echo "Failed"';
   echo ""
done

controlplane ~ ➜  ls -l /root/curl-test.sh
-rwxr-xr-x    1 root     root           216 Jul 12 15:51 /root/curl-test.sh

controlplane ~ ➜  /root/curl-test.sh
Hello, Application Version: v1 ; Color: blue OK

Hello, Application Version: v1 ; Color: blue OK

Hello, Application Version: v1 ; Color: blue OK

Hello, Application Version: v1 ; Color: blue OK

Hello, Application Version: v1 ; Color: blue OK

Hello, Application Version: v1 ; Color: blue OK

Hello, Application Version: v1 ; Color: blue OK

Hello, Application Version: v1 ; Color: blue OK

Hello, Application Version: v1 ; Color: blue OK

Hello, Application Version: v1 ; Color: blue OK

^C
controlplane ~ ✖ kubectl get deployments --all-namespaces
NAMESPACE     NAME                     READY   UP-TO-DATE   AVAILABLE   AGE
kube-system   coredns                  1/1     1            1           17m
kube-system   local-path-provisioner   1/1     1            1           17m
kube-system   metrics-server           1/1     1            1           17m
kube-system   traefik                  1/1     1            1           16m
default       frontend                 4/4     4            4           2m5s

controlplane ~ ➜  kubectl get pod/frontend -o wide
Error from server (NotFound): pods "frontend" not found

controlplane ~ ✖ kubectl get deployments/frontend -o wide
NAME       READY   UP-TO-DATE   AVAILABLE   AGE     CONTAINERS      IMAGES                      SELECTOR
frontend   4/4     4            4           2m43s   simple-webapp   kodekloud/webapp-color:v1   name=webapp

controlplane ~ ➜  kubectl get deployments/frontend -o json
{
    "apiVersion": "apps/v1",
    "kind": "Deployment",
    "metadata": {
        "annotations": {
            "deployment.kubernetes.io/revision": "1"
        },
        "creationTimestamp": "2024-08-15T20:06:09Z",
        "generation": 1,
        "name": "frontend",
        "namespace": "default",
        "resourceVersion": "1013",
        "uid": "edb2b0e0-ecb5-458b-9e9a-8998d60c305e"
    },
    "spec": {
        "minReadySeconds": 20,
        "progressDeadlineSeconds": 600,
        "replicas": 4,
        "revisionHistoryLimit": 10,
        "selector": {
            "matchLabels": {
                "name": "webapp"
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
                    "name": "webapp"
                }
            },
            "spec": {
                "containers": [
                    {
                        "image": "kodekloud/webapp-color:v1",
                        "imagePullPolicy": "IfNotPresent",
                        "name": "simple-webapp",
                        "ports": [
                            {
                                "containerPort": 8080,
                                "protocol": "TCP"
                            }
                        ],
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
        "availableReplicas": 4,
        "conditions": [
            {
                "lastTransitionTime": "2024-08-15T20:06:41Z",
                "lastUpdateTime": "2024-08-15T20:06:41Z",
                "message": "Deployment has minimum availability.",
                "reason": "MinimumReplicasAvailable",
                "status": "True",
                "type": "Available"
            },
            {
                "lastTransitionTime": "2024-08-15T20:06:09Z",
                "lastUpdateTime": "2024-08-15T20:06:41Z",
                "message": "ReplicaSet \"frontend-f8d68f98f\" has successfully progressed.",
                "reason": "NewReplicaSetAvailable",
                "status": "True",
                "type": "Progressing"
            }
        ],
        "observedGeneration": 1,
        "readyReplicas": 4,
        "replicas": 4,
        "updatedReplicas": 4
    }
}

controlplane ~ ➜  kubectl edit  deployments/frontend
deployment.apps/frontend edited

controlplane ~ ➜  kubectl get deployments/frontend -o wide
NAME       READY   UP-TO-DATE   AVAILABLE   AGE   CONTAINERS      IMAGES                      SELECTOR
frontend   5/4     2            3           29m   simple-webapp   kodekloud/webapp-color:v2   name=webapp

controlplane ~ ➜  kodekloud/webapp-color:v2
-bash: kodekloud/webapp-color:v2: No such file or directory

controlplane ~ ✖ /root/curl-test.sh
Hello, Application Version: v2 ; Color: green OK

Hello, Application Version: v1 ; Color: blue OK

Hello, Application Version: v1 ; Color: blue OK

Hello, Application Version: v2 ; Color: green OK

Hello, Application Version: v2 ; Color: green OK

Hello, Application Version: v2 ; Color: green OK

Hello, Application Version: v2 ; Color: green OK

Hello, Application Version: v2 ; Color: green OK

Hello, Application Version: v2 ; Color: green OK

Hello, Application Version: v2 ; Color: green OK

Hello, Application Version: v2 ; Color: green OK

Hello, Application Version: v2 ; Color: green OK

Hello, Application Version: v2 ; Color: green OK

Hello, Application Version: v2 ; Color: green OK

Hello, Application Version: v2 ; Color: green OK

Hello, Application Version: v1 ; Color: blue OK

Hello, Application Version: v2 ; Color: green OK

^C
controlplane ~ ✖ kubectl get deployments/frontend -o wide
NAME       READY   UP-TO-DATE   AVAILABLE   AGE   CONTAINERS      IMAGES                      SELECTOR
frontend   4/4     4            4           30m   simple-webapp   kodekloud/webapp-color:v2   name=webapp

controlplane ~ ➜  kubectl get deployments/frontend -o json
{
    "apiVersion": "apps/v1",
    "kind": "Deployment",
    "metadata": {
        "annotations": {
            "deployment.kubernetes.io/revision": "2"
        },
        "creationTimestamp": "2024-08-15T20:06:09Z",
        "generation": 2,
        "name": "frontend",
        "namespace": "default",
        "resourceVersion": "1661",
        "uid": "edb2b0e0-ecb5-458b-9e9a-8998d60c305e"
    },
    "spec": {
        "minReadySeconds": 20,
        "progressDeadlineSeconds": 600,
        "replicas": 4,
        "revisionHistoryLimit": 10,
        "selector": {
            "matchLabels": {
                "name": "webapp"
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
                    "name": "webapp"
                }
            },
            "spec": {
                "containers": [
                    {
                        "image": "kodekloud/webapp-color:v2",
                        "imagePullPolicy": "IfNotPresent",
                        "name": "simple-webapp",
                        "ports": [
                            {
                                "containerPort": 8080,
                                "protocol": "TCP"
                            }
                        ],
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
        "availableReplicas": 4,
        "conditions": [
            {
                "lastTransitionTime": "2024-08-15T20:06:41Z",
                "lastUpdateTime": "2024-08-15T20:06:41Z",
                "message": "Deployment has minimum availability.",
                "reason": "MinimumReplicasAvailable",
                "status": "True",
                "type": "Available"
            },
            {
                "lastTransitionTime": "2024-08-15T20:06:09Z",
                "lastUpdateTime": "2024-08-15T20:36:12Z",
                "message": "ReplicaSet \"frontend-69b69fcc6d\" has successfully progressed.",
                "reason": "NewReplicaSetAvailable",
                "status": "True",
                "type": "Progressing"
            }
        ],
        "observedGeneration": 2,
        "readyReplicas": 4,
        "replicas": 4,
        "updatedReplicas": 4
    }
}

controlplane ~ ➜  kubectl edit  deployments/frontend
deployment.apps/frontend edited

controlplane ~ ➜  kubectl get deployments/frontend -o json
{
    "apiVersion": "apps/v1",
    "kind": "Deployment",
    "metadata": {
        "annotations": {
            "deployment.kubernetes.io/revision": "2"
        },
        "creationTimestamp": "2024-08-15T20:06:09Z",
        "generation": 3,
        "name": "frontend",
        "namespace": "default",
        "resourceVersion": "1753",
        "uid": "edb2b0e0-ecb5-458b-9e9a-8998d60c305e"
    },
    "spec": {
        "minReadySeconds": 20,
        "progressDeadlineSeconds": 600,
        "replicas": 4,
        "revisionHistoryLimit": 10,
        "selector": {
            "matchLabels": {
                "name": "webapp"
            }
        },
        "strategy": {
            "type": "Recreate"
        },
        "template": {
            "metadata": {
                "creationTimestamp": null,
                "labels": {
                    "name": "webapp"
                }
            },
            "spec": {
                "containers": [
                    {
                        "image": "kodekloud/webapp-color:v2",
                        "imagePullPolicy": "IfNotPresent",
                        "name": "simple-webapp",
                        "ports": [
                            {
                                "containerPort": 8080,
                                "protocol": "TCP"
                            }
                        ],
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
        "availableReplicas": 4,
        "conditions": [
            {
                "lastTransitionTime": "2024-08-15T20:06:41Z",
                "lastUpdateTime": "2024-08-15T20:06:41Z",
                "message": "Deployment has minimum availability.",
                "reason": "MinimumReplicasAvailable",
                "status": "True",
                "type": "Available"
            },
            {
                "lastTransitionTime": "2024-08-15T20:06:09Z",
                "lastUpdateTime": "2024-08-15T20:36:12Z",
                "message": "ReplicaSet \"frontend-69b69fcc6d\" has successfully progressed.",
                "reason": "NewReplicaSetAvailable",
                "status": "True",
                "type": "Progressing"
            }
        ],
        "observedGeneration": 3,
        "readyReplicas": 4,
        "replicas": 4,
        "updatedReplicas": 4
    }
}

controlplane ~ ➜  kubectl get deployments/frontend -o wide
NAME       READY   UP-TO-DATE   AVAILABLE   AGE   CONTAINERS      IMAGES                      SELECTOR
frontend   4/4     4            4           34m   simple-webapp   kodekloud/webapp-color:v2   name=webapp

controlplane ~ ➜  kubectl set image deployment/frontend kodekloud/webapp-color:v3
error: the server doesn't have a resource type "kodekloud"

controlplane ~ ✖ kubectl set image deployment/frontend simple-webapp=kodekloud/webapp-color:v3
deployment.apps/frontend image updated

controlplane ~ ➜  /root/curl-test.sh
Hello, Application Version: v2 ; Color: green OK

Hello, Application Version: v2 ; Color: green OK

Hello, Application Version: v2 ; Color: green OK

Hello, Application Version: v2 ; Color: green OK

Hello, Application Version: v2 ; Color: green OK

Hello, Application Version: v2 ; Color: green OK

Hello, Application Version: v2 ; Color: green OK

Hello, Application Version: v2 ; Color: green OK

Hello, Application Version: v2 ; Color: green OK

Hello, Application Version: v2 ; Color: green OK

Hello, Application Version: v2 ; Color: green OK

Hello, Application Version: v2 ; Color: green OK

^C
controlplane ~ ✖ 

       Welcome to the KodeKloud Hands-On lab                                                                         
    __ ______  ____  ________ __ __    ____  __  ______ 
   / //_/ __ \/ __ \/ ____/ //_// /   / __ \/ / / / __ \
  / ,< / / / / / / / __/ / ,<  / /   / / / / / / / / / /
 / /| / /_/ / /_/ / /___/ /| |/ /___/ /_/ / /_/ / /_/ / 
/_/ |_\____/_____/_____/_/ |_/_____/\____/\____/_____/  
                                                        
            All rights reserved                                                                                      

controlplane ~ ➜  kubectl get pod/rabbit -o json
{
    "apiVersion": "v1",
    "kind": "Pod",
    "metadata": {
        "creationTimestamp": "2024-08-15T15:01:36Z",
        "name": "rabbit",
        "namespace": "default",
        "resourceVersion": "802",
        "uid": "80aa3c62-fed5-444c-a63e-a6de52a86843"
    },
    "spec": {
        "containers": [
            {
                "args": [
                    "sleep",
                    "1000"
                ],
                "image": "ubuntu",
                "imagePullPolicy": "Always",
                "name": "cpu-stress",
                "resources": {
                    "limits": {
                        "cpu": "2"
                    },
                    "requests": {
                        "cpu": "1"
                    }
                },
                "terminationMessagePath": "/dev/termination-log",
                "terminationMessagePolicy": "File",
                "volumeMounts": [
                    {
                        "mountPath": "/var/run/secrets/kubernetes.io/serviceaccount",
                        "name": "kube-api-access-7gmpk",
                        "readOnly": true
                    }
                ]
            }
        ],
        "dnsPolicy": "ClusterFirst",
        "enableServiceLinks": true,
        "nodeName": "controlplane",
        "preemptionPolicy": "PreemptLowerPriority",
        "priority": 0,
        "restartPolicy": "Always",
        "schedulerName": "default-scheduler",
        "securityContext": {},
        "serviceAccount": "default",
        "serviceAccountName": "default",
        "terminationGracePeriodSeconds": 30,
        "tolerations": [
            {
                "effect": "NoExecute",
                "key": "node.kubernetes.io/not-ready",
                "operator": "Exists",
                "tolerationSeconds": 300
            },
            {
                "effect": "NoExecute",
                "key": "node.kubernetes.io/unreachable",
                "operator": "Exists",
                "tolerationSeconds": 300
            }
        ],
        "volumes": [
            {
                "name": "kube-api-access-7gmpk",
                "projected": {
                    "defaultMode": 420,
                    "sources": [
                        {
                            "serviceAccountToken": {
                                "expirationSeconds": 3607,
                                "path": "token"
                            }
                        },
                        {
                            "configMap": {
                                "items": [
                                    {
                                        "key": "ca.crt",
                                        "path": "ca.crt"
                                    }
                                ],
                                "name": "kube-root-ca.crt"
                            }
                        },
                        {
                            "downwardAPI": {
                                "items": [
                                    {
                                        "fieldRef": {
                                            "apiVersion": "v1",
                                            "fieldPath": "metadata.namespace"
                                        },
                                        "path": "namespace"
                                    }
                                ]
                            }
                        }
                    ]
                }
            }
        ]
    },
    "status": {
        "conditions": [
            {
                "lastProbeTime": null,
                "lastTransitionTime": "2024-08-15T15:01:43Z",
                "status": "True",
                "type": "PodReadyToStartContainers"
            },
            {
                "lastProbeTime": null,
                "lastTransitionTime": "2024-08-15T15:01:36Z",
                "status": "True",
                "type": "Initialized"
            },
            {
                "lastProbeTime": null,
                "lastTransitionTime": "2024-08-15T15:01:36Z",
                "message": "containers with unready status: [cpu-stress]",
                "reason": "ContainersNotReady",
                "status": "False",
                "type": "Ready"
            },
            {
                "lastProbeTime": null,
                "lastTransitionTime": "2024-08-15T15:01:36Z",
                "message": "containers with unready status: [cpu-stress]",
                "reason": "ContainersNotReady",
                "status": "False",
                "type": "ContainersReady"
            },
            {
                "lastProbeTime": null,
                "lastTransitionTime": "2024-08-15T15:01:36Z",
                "status": "True",
                "type": "PodScheduled"
            }
        ],
        "containerStatuses": [
            {
                "containerID": "containerd://6b7e45e136716ed030ebdb79bcc5674204b1abd6cee0add02ea4c2e891e65183",
                "image": "docker.io/library/ubuntu:latest",
                "imageID": "docker.io/library/ubuntu@sha256:2e863c44b718727c860746568e1d54afd13b2fa71b160f5cd9058fc436217b30",
                "lastState": {
                    "terminated": {
                        "containerID": "containerd://6b7e45e136716ed030ebdb79bcc5674204b1abd6cee0add02ea4c2e891e65183",
                        "exitCode": 128,
                        "finishedAt": "2024-08-15T15:01:57Z",
                        "message": "failed to create containerd task: failed to create shim task: OCI runtime create failed: runc create failed: unable to start container process: error during container init: error setting cgroup config for procHooks process: failed to write \"200000\": write /sys/fs/cgroup/cpu,cpuacct/kubepods/burstable/pod80aa3c62-fed5-444c-a63e-a6de52a86843/6b7e45e136716ed030ebdb79bcc5674204b1abd6cee0add02ea4c2e891e65183/cpu.cfs_quota_us: invalid argument: unknown",
                        "reason": "StartError",
                        "startedAt": "1970-01-01T00:00:00Z"
                    }
                },
                "name": "cpu-stress",
                "ready": false,
                "restartCount": 2,
                "started": false,
                "state": {
                    "waiting": {
                        "message": "back-off 20s restarting failed container=cpu-stress pod=rabbit_default(80aa3c62-fed5-444c-a63e-a6de52a86843)",
                        "reason": "CrashLoopBackOff"
                    }
                }
            }
        ],
        "hostIP": "192.30.201.6",
        "hostIPs": [
            {
                "ip": "192.30.201.6"
            }
        ],
        "phase": "Running",
        "podIP": "10.42.0.9",
        "podIPs": [
            {
                "ip": "10.42.0.9"
            }
        ],
        "qosClass": "Burstable",
        "startTime": "2024-08-15T15:01:36Z"
    }
}

controlplane ~ ➜  kubectl delete pod/rabbit --force --grace-period=0
Warning: Immediate deletion does not wait for confirmation that the running resource has been terminated. The resource may continue to run on the cluster indefinitely.
pod "rabbit" force deleted

controlplane ~ ➜  kubectl get pod/elephant -o json
{
    "apiVersion": "v1",
    "kind": "Pod",
    "metadata": {
        "creationTimestamp": "2024-08-15T15:03:35Z",
        "name": "elephant",
        "namespace": "default",
        "resourceVersion": "863",
        "uid": "0ab05b0a-e122-4153-8415-ee2b772d6148"
    },
    "spec": {
        "containers": [
            {
                "args": [
                    "--vm",
                    "1",
                    "--vm-bytes",
                    "15M",
                    "--vm-hang",
                    "1"
                ],
                "command": [
                    "stress"
                ],
                "image": "polinux/stress",
                "imagePullPolicy": "Always",
                "name": "mem-stress",
                "resources": {
                    "limits": {
                        "memory": "10Mi"
                    },
                    "requests": {
                        "memory": "5Mi"
                    }
                },
                "terminationMessagePath": "/dev/termination-log",
                "terminationMessagePolicy": "File",
                "volumeMounts": [
                    {
                        "mountPath": "/var/run/secrets/kubernetes.io/serviceaccount",
                        "name": "kube-api-access-bmqst",
                        "readOnly": true
                    }
                ]
            }
        ],
        "dnsPolicy": "ClusterFirst",
        "enableServiceLinks": true,
        "nodeName": "controlplane",
        "preemptionPolicy": "PreemptLowerPriority",
        "priority": 0,
        "restartPolicy": "Always",
        "schedulerName": "default-scheduler",
        "securityContext": {},
        "serviceAccount": "default",
        "serviceAccountName": "default",
        "terminationGracePeriodSeconds": 30,
        "tolerations": [
            {
                "effect": "NoExecute",
                "key": "node.kubernetes.io/not-ready",
                "operator": "Exists",
                "tolerationSeconds": 300
            },
            {
                "effect": "NoExecute",
                "key": "node.kubernetes.io/unreachable",
                "operator": "Exists",
                "tolerationSeconds": 300
            }
        ],
        "volumes": [
            {
                "name": "kube-api-access-bmqst",
                "projected": {
                    "defaultMode": 420,
                    "sources": [
                        {
                            "serviceAccountToken": {
                                "expirationSeconds": 3607,
                                "path": "token"
                            }
                        },
                        {
                            "configMap": {
                                "items": [
                                    {
                                        "key": "ca.crt",
                                        "path": "ca.crt"
                                    }
                                ],
                                "name": "kube-root-ca.crt"
                            }
                        },
                        {
                            "downwardAPI": {
                                "items": [
                                    {
                                        "fieldRef": {
                                            "apiVersion": "v1",
                                            "fieldPath": "metadata.namespace"
                                        },
                                        "path": "namespace"
                                    }
                                ]
                            }
                        }
                    ]
                }
            }
        ]
    },
    "status": {
        "conditions": [
            {
                "lastProbeTime": null,
                "lastTransitionTime": "2024-08-15T15:03:38Z",
                "status": "True",
                "type": "PodReadyToStartContainers"
            },
            {
                "lastProbeTime": null,
                "lastTransitionTime": "2024-08-15T15:03:35Z",
                "status": "True",
                "type": "Initialized"
            },
            {
                "lastProbeTime": null,
                "lastTransitionTime": "2024-08-15T15:03:35Z",
                "message": "containers with unready status: [mem-stress]",
                "reason": "ContainersNotReady",
                "status": "False",
                "type": "Ready"
            },
            {
                "lastProbeTime": null,
                "lastTransitionTime": "2024-08-15T15:03:35Z",
                "message": "containers with unready status: [mem-stress]",
                "reason": "ContainersNotReady",
                "status": "False",
                "type": "ContainersReady"
            },
            {
                "lastProbeTime": null,
                "lastTransitionTime": "2024-08-15T15:03:35Z",
                "status": "True",
                "type": "PodScheduled"
            }
        ],
        "containerStatuses": [
            {
                "containerID": "containerd://720b7253bb461abb6c528b4bfd1fe3d647aeb2f5ab51ddba873ec973c4b975b1",
                "image": "docker.io/polinux/stress:latest",
                "imageID": "docker.io/polinux/stress@sha256:b6144f84f9c15dac80deb48d3a646b55c7043ab1d83ea0a697c09097aaad21aa",
                "lastState": {
                    "terminated": {
                        "containerID": "containerd://720b7253bb461abb6c528b4bfd1fe3d647aeb2f5ab51ddba873ec973c4b975b1",
                        "exitCode": 1,
                        "finishedAt": "2024-08-15T15:03:39Z",
                        "reason": "OOMKilled",
                        "startedAt": "2024-08-15T15:03:39Z"
                    }
                },
                "name": "mem-stress",
                "ready": false,
                "restartCount": 1,
                "started": false,
                "state": {
                    "waiting": {
                        "message": "back-off 10s restarting failed container=mem-stress pod=elephant_default(0ab05b0a-e122-4153-8415-ee2b772d6148)",
                        "reason": "CrashLoopBackOff"
                    }
                }
            }
        ],
        "hostIP": "192.30.201.6",
        "hostIPs": [
            {
                "ip": "192.30.201.6"
            }
        ],
        "phase": "Running",
        "podIP": "10.42.0.10",
        "podIPs": [
            {
                "ip": "10.42.0.10"
            }
        ],
        "qosClass": "Burstable",
        "startTime": "2024-08-15T15:03:35Z"
    }
}

controlplane ~ ➜  kubectl edit pod/elephant
error: pods "elephant" is invalid
A copy of your changes has been stored to "/tmp/kubectl-edit-2622819518.yaml"
error: Edit cancelled, no valid changes were saved.

controlplane ~ ✖ kubectl get  pod/elephant -o yaml > pod-elephant.yaml

controlplane ~ ➜  kubectl delete pod/elephant --grace-period=0 --force
Warning: Immediate deletion does not wait for confirmation that the running resource has been terminated. The resource may continue to run on the cluster indefinitely.
pod "elephant" force deleted

controlplane ~ ➜  vi pod-elephant.yaml

controlplane ~ ➜  kubectl create -f pod-elephant.yaml
pod/elephant created

controlplane ~ ➜  kubectl get pod/elephant -o wide
NAME       READY   STATUS    RESTARTS   AGE     IP           NODE           NOMINATED NODE   READINESS GATES
elephant   1/1     Running   0          5m48s   10.42.0.11   controlplane   <none>           <none>

controlplane ~ ➜  kubectl delete pod/elephant --grace-period=0 --force
Warning: Immediate deletion does not wait for confirmation that the running resource has been terminated. The resource may continue to run on the cluster indefinitely.
pod "elephant" force deleted

controlplane ~ ➜  

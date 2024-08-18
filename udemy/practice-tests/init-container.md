    "name": "red-container",
    "resources": {},
    "terminationMessagePath": "/dev/termination-log",
    "terminationMessagePolicy": "File",
    "volumeMounts": [
      {
        "mountPath": "/var/run/secrets/kubernetes.io/serviceaccount",
        "name": "kube-api-access-6lpqm",
        "readOnly": true
      }
    ]
  }
]

controlplane ~ ➜  kubectl get pods/green -o json | jq .spec.containers
[
  {
    "command": [
      "sh",
      "-c",
      "echo The app is running! && sleep 3600"
    ],
    "image": "busybox:1.28",
    "imagePullPolicy": "IfNotPresent",
    "name": "green-container-1",
    "resources": {},
    "terminationMessagePath": "/dev/termination-log",
    "terminationMessagePolicy": "File",
    "volumeMounts": [
      {
        "mountPath": "/var/run/secrets/kubernetes.io/serviceaccount",
        "name": "kube-api-access-pcr5f",
        "readOnly": true
      }
    ]
  },
  {
    "command": [
      "sh",
      "-c",
      "echo The app is running! && sleep 3600"
    ],
    "image": "busybox:1.28",
    "imagePullPolicy": "IfNotPresent",
    "name": "green-container-2",
    "resources": {},
    "terminationMessagePath": "/dev/termination-log",
    "terminationMessagePolicy": "File",
    "volumeMounts": [
      {
        "mountPath": "/var/run/secrets/kubernetes.io/serviceaccount",
        "name": "kube-api-access-pcr5f",
        "readOnly": true
      }
    ]
  }
]

controlplane ~ ➜  kubectl get pods/blue -o json | jq .spec.containers
[
  {
    "command": [
      "sh",
      "-c",
      "echo The app is running! && sleep 3600"
    ],
    "image": "busybox:1.28",
    "imagePullPolicy": "IfNotPresent",
    "name": "green-container-1",
    "resources": {},
    "terminationMessagePath": "/dev/termination-log",
    "terminationMessagePolicy": "File",
    "volumeMounts": [
      {
        "mountPath": "/var/run/secrets/kubernetes.io/serviceaccount",
        "name": "kube-api-access-25nqn",
        "readOnly": true
      }
    ]
  }
]

controlplane ~ ➜  kubectl get pods/blue -o json | jq .spec.initContainers
[
  {
    "command": [
      "sh",
      "-c",
      "sleep 5"
    ],
    "image": "busybox",
    "imagePullPolicy": "Always",
    "name": "init-myservice",
    "resources": {},
    "terminationMessagePath": "/dev/termination-log",
    "terminationMessagePolicy": "File",
    "volumeMounts": [
      {
        "mountPath": "/var/run/secrets/kubernetes.io/serviceaccount",
        "name": "kube-api-access-25nqn",
        "readOnly": true
      }
    ]
  }
]

controlplane ~ ➜  kubectl get pods/blue -o json 
{
    "apiVersion": "v1",
    "kind": "Pod",
    "metadata": {
        "creationTimestamp": "2024-08-16T01:54:04Z",
        "name": "blue",
        "namespace": "default",
        "resourceVersion": "1014",
        "uid": "3e8790b4-07f2-4b62-8b54-0ad2baea0b94"
    },
    "spec": {
        "containers": [
            {
                "command": [
                    "sh",
                    "-c",
                    "echo The app is running! \u0026\u0026 sleep 3600"
                ],
                "image": "busybox:1.28",
                "imagePullPolicy": "IfNotPresent",
                "name": "green-container-1",
                "resources": {},
                "terminationMessagePath": "/dev/termination-log",
                "terminationMessagePolicy": "File",
                "volumeMounts": [
                    {
                        "mountPath": "/var/run/secrets/kubernetes.io/serviceaccount",
                        "name": "kube-api-access-25nqn",
                        "readOnly": true
                    }
                ]
            }
        ],
        "dnsPolicy": "ClusterFirst",
        "enableServiceLinks": true,
        "initContainers": [
            {
                "command": [
                    "sh",
                    "-c",
                    "sleep 5"
                ],
                "image": "busybox",
                "imagePullPolicy": "Always",
                "name": "init-myservice",
                "resources": {},
                "terminationMessagePath": "/dev/termination-log",
                "terminationMessagePolicy": "File",
                "volumeMounts": [
                    {
                        "mountPath": "/var/run/secrets/kubernetes.io/serviceaccount",
                        "name": "kube-api-access-25nqn",
                        "readOnly": true
                    }
                ]
            }
        ],
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
                "name": "kube-api-access-25nqn",
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
                "lastTransitionTime": "2024-08-16T01:54:06Z",
                "status": "True",
                "type": "PodReadyToStartContainers"
            },
            {
                "lastProbeTime": null,
                "lastTransitionTime": "2024-08-16T01:54:13Z",
                "status": "True",
                "type": "Initialized"
            },
            {
                "lastProbeTime": null,
                "lastTransitionTime": "2024-08-16T01:54:14Z",
                "status": "True",
                "type": "Ready"
            },
            {
                "lastProbeTime": null,
                "lastTransitionTime": "2024-08-16T01:54:14Z",
                "status": "True",
                "type": "ContainersReady"
            },
            {
                "lastProbeTime": null,
                "lastTransitionTime": "2024-08-16T01:54:04Z",
                "status": "True",
                "type": "PodScheduled"
            }
        ],
        "containerStatuses": [
            {
                "containerID": "containerd://55318bb08c3a8f33df63e7e924955b4b5eb1545102dff146a0758cabb8a06e20",
                "image": "docker.io/library/busybox:1.28",
                "imageID": "docker.io/library/busybox@sha256:141c253bc4c3fd0a201d32dc1f493bcf3fff003b6df416dea4f41046e0f37d47",
                "lastState": {},
                "name": "green-container-1",
                "ready": true,
                "restartCount": 0,
                "started": true,
                "state": {
                    "running": {
                        "startedAt": "2024-08-16T01:54:14Z"
                    }
                }
            }
        ],
        "hostIP": "192.3.127.3",
        "hostIPs": [
            {
                "ip": "192.3.127.3"
            }
        ],
        "initContainerStatuses": [
            {
                "containerID": "containerd://48aae571d5ebd0e4aed09cddf263216ef739b621994f5c433bb9baaa3a2edcbe",
                "image": "docker.io/library/busybox:latest",
                "imageID": "docker.io/library/busybox@sha256:9ae97d36d26566ff84e8893c64a6dc4fe8ca6d1144bf5b87b2b85a32def253c7",
                "lastState": {},
                "name": "init-myservice",
                "ready": true,
                "restartCount": 0,
                "started": false,
                "state": {
                    "terminated": {
                        "containerID": "containerd://48aae571d5ebd0e4aed09cddf263216ef739b621994f5c433bb9baaa3a2edcbe",
                        "exitCode": 0,
                        "finishedAt": "2024-08-16T01:54:11Z",
                        "reason": "Completed",
                        "startedAt": "2024-08-16T01:54:06Z"
                    }
                }
            }
        ],
        "phase": "Running",
        "podIP": "10.42.0.11",
        "podIPs": [
            {
                "ip": "10.42.0.11"
            }
        ],
        "qosClass": "BestEffort",
        "startTime": "2024-08-16T01:54:04Z"
    }
}

controlplane ~ ➜  kubectl get pods/blue -o json | jq .status
{
  "conditions": [
    {
      "lastProbeTime": null,
      "lastTransitionTime": "2024-08-16T01:54:06Z",
      "status": "True",
      "type": "PodReadyToStartContainers"
    },
    {
      "lastProbeTime": null,
      "lastTransitionTime": "2024-08-16T01:54:13Z",
      "status": "True",
      "type": "Initialized"
    },
    {
      "lastProbeTime": null,
      "lastTransitionTime": "2024-08-16T01:54:14Z",
      "status": "True",
      "type": "Ready"
    },
    {
      "lastProbeTime": null,
      "lastTransitionTime": "2024-08-16T01:54:14Z",
      "status": "True",
      "type": "ContainersReady"
    },
    {
      "lastProbeTime": null,
      "lastTransitionTime": "2024-08-16T01:54:04Z",
      "status": "True",
      "type": "PodScheduled"
    }
  ],
  "containerStatuses": [
    {
      "containerID": "containerd://55318bb08c3a8f33df63e7e924955b4b5eb1545102dff146a0758cabb8a06e20",
      "image": "docker.io/library/busybox:1.28",
      "imageID": "docker.io/library/busybox@sha256:141c253bc4c3fd0a201d32dc1f493bcf3fff003b6df416dea4f41046e0f37d47",
      "lastState": {},
      "name": "green-container-1",
      "ready": true,
      "restartCount": 0,
      "started": true,
      "state": {
        "running": {
          "startedAt": "2024-08-16T01:54:14Z"
        }
      }
    }
  ],
  "hostIP": "192.3.127.3",
  "hostIPs": [
    {
      "ip": "192.3.127.3"
    }
  ],
  "initContainerStatuses": [
    {
      "containerID": "containerd://48aae571d5ebd0e4aed09cddf263216ef739b621994f5c433bb9baaa3a2edcbe",
      "image": "docker.io/library/busybox:latest",
      "imageID": "docker.io/library/busybox@sha256:9ae97d36d26566ff84e8893c64a6dc4fe8ca6d1144bf5b87b2b85a32def253c7",
      "lastState": {},
      "name": "init-myservice",
      "ready": true,
      "restartCount": 0,
      "started": false,
      "state": {
        "terminated": {
          "containerID": "containerd://48aae571d5ebd0e4aed09cddf263216ef739b621994f5c433bb9baaa3a2edcbe",
          "exitCode": 0,
          "finishedAt": "2024-08-16T01:54:11Z",
          "reason": "Completed",
          "startedAt": "2024-08-16T01:54:06Z"
        }
      }
    }
  ],
  "phase": "Running",
  "podIP": "10.42.0.11",
  "podIPs": [
    {
      "ip": "10.42.0.11"
    }
  ],
  "qosClass": "BestEffort",
  "startTime": "2024-08-16T01:54:04Z"
}

controlplane ~ ➜  kubectl get pods/purple -o json 
{
    "apiVersion": "v1",
    "kind": "Pod",
    "metadata": {
        "creationTimestamp": "2024-08-16T02:00:59Z",
        "name": "purple",
        "namespace": "default",
        "resourceVersion": "1144",
        "uid": "04c90f0f-5d1c-4d95-9082-d7d6365c1af3"
    },
    "spec": {
        "containers": [
            {
                "command": [
                    "sh",
                    "-c",
                    "echo The app is running! \u0026\u0026 sleep 3600"
                ],
                "image": "busybox:1.28",
                "imagePullPolicy": "IfNotPresent",
                "name": "purple-container",
                "resources": {},
                "terminationMessagePath": "/dev/termination-log",
                "terminationMessagePolicy": "File",
                "volumeMounts": [
                    {
                        "mountPath": "/var/run/secrets/kubernetes.io/serviceaccount",
                        "name": "kube-api-access-vvdz8",
                        "readOnly": true
                    }
                ]
            }
        ],
        "dnsPolicy": "ClusterFirst",
        "enableServiceLinks": true,
        "initContainers": [
            {
                "command": [
                    "sh",
                    "-c",
                    "sleep 600"
                ],
                "image": "busybox:1.28",
                "imagePullPolicy": "IfNotPresent",
                "name": "warm-up-1",
                "resources": {},
                "terminationMessagePath": "/dev/termination-log",
                "terminationMessagePolicy": "File",
                "volumeMounts": [
                    {
                        "mountPath": "/var/run/secrets/kubernetes.io/serviceaccount",
                        "name": "kube-api-access-vvdz8",
                        "readOnly": true
                    }
                ]
            },
            {
                "command": [
                    "sh",
                    "-c",
                    "sleep 1200"
                ],
                "image": "busybox:1.28",
                "imagePullPolicy": "IfNotPresent",
                "name": "warm-up-2",
                "resources": {},
                "terminationMessagePath": "/dev/termination-log",
                "terminationMessagePolicy": "File",
                "volumeMounts": [
                    {
                        "mountPath": "/var/run/secrets/kubernetes.io/serviceaccount",
                        "name": "kube-api-access-vvdz8",
                        "readOnly": true
                    }
                ]
            }
        ],
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
                "name": "kube-api-access-vvdz8",
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
                "lastTransitionTime": "2024-08-16T02:01:01Z",
                "status": "True",
                "type": "PodReadyToStartContainers"
            },
            {
                "lastProbeTime": null,
                "lastTransitionTime": "2024-08-16T02:00:59Z",
                "message": "containers with incomplete status: [warm-up-1 warm-up-2]",
                "reason": "ContainersNotInitialized",
                "status": "False",
                "type": "Initialized"
            },
            {
                "lastProbeTime": null,
                "lastTransitionTime": "2024-08-16T02:00:59Z",
                "message": "containers with unready status: [purple-container]",
                "reason": "ContainersNotReady",
                "status": "False",
                "type": "Ready"
            },
            {
                "lastProbeTime": null,
                "lastTransitionTime": "2024-08-16T02:00:59Z",
                "message": "containers with unready status: [purple-container]",
                "reason": "ContainersNotReady",
                "status": "False",
                "type": "ContainersReady"
            },
            {
                "lastProbeTime": null,
                "lastTransitionTime": "2024-08-16T02:00:59Z",
                "status": "True",
                "type": "PodScheduled"
            }
        ],
        "containerStatuses": [
            {
                "image": "busybox:1.28",
                "imageID": "",
                "lastState": {},
                "name": "purple-container",
                "ready": false,
                "restartCount": 0,
                "started": false,
                "state": {
                    "waiting": {
                        "reason": "PodInitializing"
                    }
                }
            }
        ],
        "hostIP": "192.3.127.3",
        "hostIPs": [
            {
                "ip": "192.3.127.3"
            }
        ],
        "initContainerStatuses": [
            {
                "containerID": "containerd://2f888dc43be436ebf972c13623aa855938a854346039319836a121338b40d096",
                "image": "docker.io/library/busybox:1.28",
                "imageID": "docker.io/library/busybox@sha256:141c253bc4c3fd0a201d32dc1f493bcf3fff003b6df416dea4f41046e0f37d47",
                "lastState": {},
                "name": "warm-up-1",
                "ready": false,
                "restartCount": 0,
                "started": true,
                "state": {
                    "running": {
                        "startedAt": "2024-08-16T02:01:00Z"
                    }
                }
            },
            {
                "image": "busybox:1.28",
                "imageID": "",
                "lastState": {},
                "name": "warm-up-2",
                "ready": false,
                "restartCount": 0,
                "started": false,
                "state": {
                    "waiting": {
                        "reason": "PodInitializing"
                    }
                }
            }
        ],
        "phase": "Pending",
        "podIP": "10.42.0.12",
        "podIPs": [
            {
                "ip": "10.42.0.12"
            }
        ],
        "qosClass": "BestEffort",
        "startTime": "2024-08-16T02:00:59Z"
    }
}

controlplane ~ ➜  kubectl get pods/blue -o json | jq .spec.initContainers
[
  {
    "command": [
      "sh",
      "-c",
      "sleep 5"
    ],
    "image": "busybox",
    "imagePullPolicy": "Always",
    "name": "init-myservice",
    "resources": {},
    "terminationMessagePath": "/dev/termination-log",
    "terminationMessagePolicy": "File",
    "volumeMounts": [
      {
        "mountPath": "/var/run/secrets/kubernetes.io/serviceaccount",
        "name": "kube-api-access-25nqn",
        "readOnly": true
      }
    ]
  }
]

controlplane ~ ➜  kubectl get pods/purple -o json | jq .spec.initContainers
[
  {
    "command": [
      "sh",
      "-c",
      "sleep 600"
    ],
    "image": "busybox:1.28",
    "imagePullPolicy": "IfNotPresent",
    "name": "warm-up-1",
    "resources": {},
    "terminationMessagePath": "/dev/termination-log",
    "terminationMessagePolicy": "File",
    "volumeMounts": [
      {
        "mountPath": "/var/run/secrets/kubernetes.io/serviceaccount",
        "name": "kube-api-access-vvdz8",
        "readOnly": true
      }
    ]
  },
  {
    "command": [
      "sh",
      "-c",
      "sleep 1200"
    ],
    "image": "busybox:1.28",
    "imagePullPolicy": "IfNotPresent",
    "name": "warm-up-2",
    "resources": {},
    "terminationMessagePath": "/dev/termination-log",
    "terminationMessagePolicy": "File",
    "volumeMounts": [
      {
        "mountPath": "/var/run/secrets/kubernetes.io/serviceaccount",
        "name": "kube-api-access-vvdz8",
        "readOnly": true
      }
    ]
  }
]

controlplane ~ ➜  kubectl get pods/purple -o json | jq .status
{
  "conditions": [
    {
      "lastProbeTime": null,
      "lastTransitionTime": "2024-08-16T02:01:01Z",
      "status": "True",
      "type": "PodReadyToStartContainers"
    },
    {
      "lastProbeTime": null,
      "lastTransitionTime": "2024-08-16T02:00:59Z",
      "message": "containers with incomplete status: [warm-up-1 warm-up-2]",
      "reason": "ContainersNotInitialized",
      "status": "False",
      "type": "Initialized"
    },
    {
      "lastProbeTime": null,
      "lastTransitionTime": "2024-08-16T02:00:59Z",
      "message": "containers with unready status: [purple-container]",
      "reason": "ContainersNotReady",
      "status": "False",
      "type": "Ready"
    },
    {
      "lastProbeTime": null,
      "lastTransitionTime": "2024-08-16T02:00:59Z",
      "message": "containers with unready status: [purple-container]",
      "reason": "ContainersNotReady",
      "status": "False",
      "type": "ContainersReady"
    },
    {
      "lastProbeTime": null,
      "lastTransitionTime": "2024-08-16T02:00:59Z",
      "status": "True",
      "type": "PodScheduled"
    }
  ],
  "containerStatuses": [
    {
      "image": "busybox:1.28",
      "imageID": "",
      "lastState": {},
      "name": "purple-container",
      "ready": false,
      "restartCount": 0,
      "started": false,
      "state": {
        "waiting": {
          "reason": "PodInitializing"
        }
      }
    }
  ],
  "hostIP": "192.3.127.3",
  "hostIPs": [
    {
      "ip": "192.3.127.3"
    }
  ],
  "initContainerStatuses": [
    {
      "containerID": "containerd://2f888dc43be436ebf972c13623aa855938a854346039319836a121338b40d096",
      "image": "docker.io/library/busybox:1.28",
      "imageID": "docker.io/library/busybox@sha256:141c253bc4c3fd0a201d32dc1f493bcf3fff003b6df416dea4f41046e0f37d47",
      "lastState": {},
      "name": "warm-up-1",
      "ready": false,
      "restartCount": 0,
      "started": true,
      "state": {
        "running": {
          "startedAt": "2024-08-16T02:01:00Z"
        }
      }
    },
    {
      "image": "busybox:1.28",
      "imageID": "",
      "lastState": {},
      "name": "warm-up-2",
      "ready": false,
      "restartCount": 0,
      "started": false,
      "state": {
        "waiting": {
          "reason": "PodInitializing"
        }
      }
    }
  ],
  "phase": "Pending",
  "podIP": "10.42.0.12",
  "podIPs": [
    {
      "ip": "10.42.0.12"
    }
  ],
  "qosClass": "BestEffort",
  "startTime": "2024-08-16T02:00:59Z"
}

controlplane ~ ➜  kubectl get pods/purple -o yaml
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: "2024-08-16T02:00:59Z"
  name: purple
  namespace: default
  resourceVersion: "1144"
  uid: 04c90f0f-5d1c-4d95-9082-d7d6365c1af3
spec:
  containers:
  - command:
    - sh
    - -c
    - echo The app is running! && sleep 3600
    image: busybox:1.28
    imagePullPolicy: IfNotPresent
    name: purple-container
    resources: {}
    terminationMessagePath: /dev/termination-log
    terminationMessagePolicy: File
    volumeMounts:
    - mountPath: /var/run/secrets/kubernetes.io/serviceaccount
      name: kube-api-access-vvdz8
      readOnly: true
  dnsPolicy: ClusterFirst
  enableServiceLinks: true
  initContainers:
  - command:
    - sh
    - -c
    - sleep 600
    image: busybox:1.28
    imagePullPolicy: IfNotPresent
    name: warm-up-1
    resources: {}
    terminationMessagePath: /dev/termination-log
    terminationMessagePolicy: File
    volumeMounts:
    - mountPath: /var/run/secrets/kubernetes.io/serviceaccount
      name: kube-api-access-vvdz8
      readOnly: true
  - command:
    - sh
    - -c
    - sleep 1200
    image: busybox:1.28
    imagePullPolicy: IfNotPresent
    name: warm-up-2
    resources: {}
    terminationMessagePath: /dev/termination-log
    terminationMessagePolicy: File
    volumeMounts:
    - mountPath: /var/run/secrets/kubernetes.io/serviceaccount
      name: kube-api-access-vvdz8
      readOnly: true
  nodeName: controlplane
  preemptionPolicy: PreemptLowerPriority
  priority: 0
  restartPolicy: Always
  schedulerName: default-scheduler
  securityContext: {}
  serviceAccount: default
  serviceAccountName: default
  terminationGracePeriodSeconds: 30
  tolerations:
  - effect: NoExecute
    key: node.kubernetes.io/not-ready
    operator: Exists
    tolerationSeconds: 300
  - effect: NoExecute
    key: node.kubernetes.io/unreachable
    operator: Exists
    tolerationSeconds: 300
  volumes:
  - name: kube-api-access-vvdz8
    projected:
      defaultMode: 420
      sources:
      - serviceAccountToken:
          expirationSeconds: 3607
          path: token
      - configMap:
          items:
          - key: ca.crt
            path: ca.crt
          name: kube-root-ca.crt
      - downwardAPI:
          items:
          - fieldRef:
              apiVersion: v1
              fieldPath: metadata.namespace
            path: namespace
status:
  conditions:
  - lastProbeTime: null
    lastTransitionTime: "2024-08-16T02:01:01Z"
    status: "True"
    type: PodReadyToStartContainers
  - lastProbeTime: null
    lastTransitionTime: "2024-08-16T02:00:59Z"
    message: 'containers with incomplete status: [warm-up-1 warm-up-2]'
    reason: ContainersNotInitialized
    status: "False"
    type: Initialized
  - lastProbeTime: null
    lastTransitionTime: "2024-08-16T02:00:59Z"
    message: 'containers with unready status: [purple-container]'
    reason: ContainersNotReady
    status: "False"
    type: Ready
  - lastProbeTime: null
    lastTransitionTime: "2024-08-16T02:00:59Z"
    message: 'containers with unready status: [purple-container]'
    reason: ContainersNotReady
    status: "False"
    type: ContainersReady
  - lastProbeTime: null
    lastTransitionTime: "2024-08-16T02:00:59Z"
    status: "True"
    type: PodScheduled
  containerStatuses:
  - image: busybox:1.28
    imageID: ""
    lastState: {}
    name: purple-container
    ready: false
    restartCount: 0
    started: false
    state:
      waiting:
        reason: PodInitializing
  hostIP: 192.3.127.3
  hostIPs:
  - ip: 192.3.127.3
  initContainerStatuses:
  - containerID: containerd://2f888dc43be436ebf972c13623aa855938a854346039319836a121338b40d096
    image: docker.io/library/busybox:1.28
    imageID: docker.io/library/busybox@sha256:141c253bc4c3fd0a201d32dc1f493bcf3fff003b6df416dea4f41046e0f37d47
    lastState: {}
    name: warm-up-1
    ready: false
    restartCount: 0
    started: true
    state:
      running:
        startedAt: "2024-08-16T02:01:00Z"
  - image: busybox:1.28
    imageID: ""
    lastState: {}
    name: warm-up-2
    ready: false
    restartCount: 0
    started: false
    state:
      waiting:
        reason: PodInitializing
  phase: Pending
  podIP: 10.42.0.12
  podIPs:
  - ip: 10.42.0.12
  qosClass: BestEffort
  startTime: "2024-08-16T02:00:59Z"

controlplane ~ ➜  kubectl get pod/red
NAME   READY   STATUS    RESTARTS   AGE
red    1/1     Running   0          17m

controlplane ~ ➜  kubectl get pod/red -o yaml ? red.yaml
error: there is no need to specify a resource type as a separate argument when passing arguments in resource/name form (e.g. 'kubectl get resource/<resource_name>' instead of 'kubectl get resource resource/<resource_name>'

controlplane ~ ✖ kubectl get pod/red -o yaml > red.yaml

controlplane ~ ➜  vi red.yaml

controlplane ~ ➜  kubectl delete pod/red --force --grace-period
error: flag needs an argument: --grace-period
See 'kubectl delete --help' for usage.

controlplane ~ ✖ kubectl delete pod/red --force --grace-period=0
Warning: Immediate deletion does not wait for confirmation that the running resource has been terminated. The resource may continue to run on the cluster indefinitely.
pod "red" force deleted

controlplane ~ ➜  kubectl create -f red.yaml
pod/red created

controlplane ~ ➜  kubectl get pods 
NAME     READY   STATUS                  RESTARTS      AGE
green    2/2     Running                 0             21m
blue     1/1     Running                 0             21m
purple   0/1     Init:1/2                0             14m
red      1/1     Running                 0             43s
orange   0/1     Init:CrashLoopBackOff   2 (18s ago)   38s

controlplane ~ ➜  kubectl edit pod/orange
error: pods "orange" is invalid
A copy of your changes has been stored to "/tmp/kubectl-edit-299196387.yaml"
error: Edit cancelled, no valid changes were saved.

controlplane ~ ✖ kubectl delete pod/orange --force --grace-period=0
Warning: Immediate deletion does not wait for confirmation that the running resource has been terminated. The resource may continue to run on the cluster indefinitely.
pod "orange" force deleted

controlplane ~ ➜  kubectl create -f /tmp/kubectl-edit-299196387.yaml
pod/orange created

controlplane ~ ➜  kubectl get pods/orange -o wide 
NAME     READY   STATUS    RESTARTS   AGE   IP           NODE           NOMINATED NODE   READINESS GATES
orange   1/1     Running   0          13s   10.42.0.15   controlplane   <none>           <none>

controlplane ~ ➜  

       Welcome to the KodeKloud Hands-On lab                                                                         
    __ ______  ____  ________ __ __    ____  __  ______ 
   / //_/ __ \/ __ \/ ____/ //_// /   / __ \/ / / / __ \
  / ,< / / / / / / / __/ / ,<  / /   / / / / / / / / / /
 / /| / /_/ / /_/ / /___/ /| |/ /___/ /_/ / /_/ / /_/ / 
/_/ |_\____/_____/_____/_/ |_/_____/\____/\____/_____/  
                                                        
            All rights reserved                                                                                      

controlplane ~ ➜  kubectl get nodes
NAME           STATUS   ROLES           AGE   VERSION
controlplane   Ready    control-plane   16m   v1.30.0
node01         Ready    <none>          16m   v1.30.0

controlplane ~ ➜  kubectl describe  node/node01 | grep -i taint
Taints:             <none>

controlplane ~ ➜  kubectl taint --help
Update the taints on one or more nodes.

  *  A taint consists of a key, value, and effect. As an argument here, it is expressed as
key=value:effect.
  *  The key must begin with a letter or number, and may contain letters, numbers, hyphens, dots,
and underscores, up to 253 characters.
  *  Optionally, the key can begin with a DNS subdomain prefix and a single '/', like
example.com/my-app.
  *  The value is optional. If given, it must begin with a letter or number, and may contain
letters, numbers, hyphens, dots, and underscores, up to 63 characters.
  *  The effect must be NoSchedule, PreferNoSchedule or NoExecute.
  *  Currently taint can only apply to node.

Examples:
  # Update node 'foo' with a taint with key 'dedicated' and value 'special-user' and effect
'NoSchedule'
  # If a taint with that key and effect already exists, its value is replaced as specified
  kubectl taint nodes foo dedicated=special-user:NoSchedule
  
  # Remove from node 'foo' the taint with key 'dedicated' and effect 'NoSchedule' if one exists
  kubectl taint nodes foo dedicated:NoSchedule-
  
  # Remove from node 'foo' all the taints with key 'dedicated'
  kubectl taint nodes foo dedicated-
  
  # Add a taint with key 'dedicated' on nodes having label myLabel=X
  kubectl taint node -l myLabel=X  dedicated=foo:PreferNoSchedule
  
  # Add to node 'foo' a taint with key 'bar' and no value
  kubectl taint nodes foo bar:NoSchedule

Options:
    --all=false:
        Select all nodes in the cluster

    --allow-missing-template-keys=true:
        If true, ignore any errors in templates when a field or map key is missing in the
        template. Only applies to golang and jsonpath output formats.

    --dry-run='none':
        Must be "none", "server", or "client". If client strategy, only print the object that
        would be sent, without sending it. If server strategy, submit server-side request without
        persisting the resource.

    --field-manager='kubectl-taint':
        Name of the manager used to track field ownership.

    -o, --output='':
        Output format. One of: (json, yaml, name, go-template, go-template-file, template,
        templatefile, jsonpath, jsonpath-as-json, jsonpath-file).

    --overwrite=false:
        If true, allow taints to be overwritten, otherwise reject taint updates that overwrite
        existing taints.

    -l, --selector='':
        Selector (label query) to filter on, supports '=', '==', and '!='.(e.g. -l
        key1=value1,key2=value2). Matching objects must satisfy all of the specified label
        constraints.

    --show-managed-fields=false:
        If true, keep the managedFields when printing objects in JSON or YAML format.

    --template='':
        Template string or path to template file to use when -o=go-template, -o=go-template-file.
        The template format is golang templates
        [http://golang.org/pkg/text/template/#pkg-overview].

    --validate='strict':
        Must be one of: strict (or true), warn, ignore (or false).              "true" or "strict" will use a
        schema to validate the input and fail the request if invalid. It will perform server side
        validation if ServerSideFieldValidation is enabled on the api-server, but will fall back
        to less reliable client-side validation if not.                 "warn" will warn about unknown or
        duplicate fields without blocking the request if server-side field validation is enabled
        on the API server, and behave as "ignore" otherwise.            "false" or "ignore" will not
        perform any schema validation, silently dropping any unknown or duplicate fields.

Usage:
  kubectl taint NODE NAME KEY_1=VAL_1:TAINT_EFFECT_1 ... KEY_N=VAL_N:TAINT_EFFECT_N [options]

Use "kubectl options" for a list of global command-line options (applies to all commands).

controlplane ~ ➜  kubectl taint node01 spray=mortein:NoSchedule
the server doesn't have a resource type "node01"

controlplane ~ ✖ kubectl taint node/node01 spray=mortein:NoSchedule
the server doesn't have a resource type "node/node01"

controlplane ~ ✖ kubectl describe  node/node01 | grep -i taint
Taints:             <none>

controlplane ~ ➜  kubectl taint node/node01  spray=mortein:NoSchedule
the server doesn't have a resource type "node/node01"

controlplane ~ ✖ kubectl taint nodes node01  spray=mortein:NoSchedule
node/node01 tainted

controlplane ~ ➜  kubectl run mosquito --image=nginx 
pod/mosquito created

controlplane ~ ➜  kubectl get pod/mosquito
NAME       READY   STATUS    RESTARTS   AGE
mosquito   0/1     Pending   0          22s

controlplane ~ ➜  kubectl get pod/mosquito -o json
{
    "apiVersion": "v1",
    "kind": "Pod",
    "metadata": {
        "creationTimestamp": "2024-08-15T02:10:26Z",
        "labels": {
            "run": "mosquito"
        },
        "name": "mosquito",
        "namespace": "default",
        "resourceVersion": "2347",
        "uid": "7fc59be3-1d39-4520-b618-f37de7045087"
    },
    "spec": {
        "containers": [
            {
                "image": "nginx",
                "imagePullPolicy": "Always",
                "name": "mosquito",
                "resources": {},
                "terminationMessagePath": "/dev/termination-log",
                "terminationMessagePolicy": "File",
                "volumeMounts": [
                    {
                        "mountPath": "/var/run/secrets/kubernetes.io/serviceaccount",
                        "name": "kube-api-access-jj5kd",
                        "readOnly": true
                    }
                ]
            }
        ],
        "dnsPolicy": "ClusterFirst",
        "enableServiceLinks": true,
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
                "name": "kube-api-access-jj5kd",
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
                "lastTransitionTime": "2024-08-15T02:10:26Z",
                "message": "0/2 nodes are available: 1 node(s) had untolerated taint {node-role.kubernetes.io/control-plane: }, 1 node(s) had untolerated taint {spray: mortein}. preemption: 0/2 nodes are available: 2 Preemption is not helpful for scheduling.",
                "reason": "Unschedulable",
                "status": "False",
                "type": "PodScheduled"
            }
        ],
        "phase": "Pending",
        "qosClass": "BestEffort"
    }
}

controlplane ~ ➜  kubectl run bee --image=nginx 
pod/bee created

controlplane ~ ➜  kubectl edit pod/bee
pod/bee edited

controlplane ~ ➜  kubectl get pod/bee -o json
{
    "apiVersion": "v1",
    "kind": "Pod",
    "metadata": {
        "creationTimestamp": "2024-08-15T02:11:45Z",
        "labels": {
            "run": "bee"
        },
        "name": "bee",
        "namespace": "default",
        "resourceVersion": "2838",
        "uid": "1b67f9e9-1a6a-4f5f-a926-c8794122dc7c"
    },
    "spec": {
        "containers": [
            {
                "image": "nginx",
                "imagePullPolicy": "Always",
                "name": "bee",
                "resources": {},
                "terminationMessagePath": "/dev/termination-log",
                "terminationMessagePolicy": "File",
                "volumeMounts": [
                    {
                        "mountPath": "/var/run/secrets/kubernetes.io/serviceaccount",
                        "name": "kube-api-access-4bxbq",
                        "readOnly": true
                    }
                ]
            }
        ],
        "dnsPolicy": "ClusterFirst",
        "enableServiceLinks": true,
        "nodeName": "node01",
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
            },
            {
                "effect": "NoSchedule",
                "key": "spray",
                "operator": "Equal",
                "value": "mortein"
            }
        ],
        "volumes": [
            {
                "name": "kube-api-access-4bxbq",
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
                "lastTransitionTime": "2024-08-15T02:16:06Z",
                "status": "True",
                "type": "PodReadyToStartContainers"
            },
            {
                "lastProbeTime": null,
                "lastTransitionTime": "2024-08-15T02:15:59Z",
                "status": "True",
                "type": "Initialized"
            },
            {
                "lastProbeTime": null,
                "lastTransitionTime": "2024-08-15T02:16:06Z",
                "status": "True",
                "type": "Ready"
            },
            {
                "lastProbeTime": null,
                "lastTransitionTime": "2024-08-15T02:16:06Z",
                "status": "True",
                "type": "ContainersReady"
            },
            {
                "lastProbeTime": null,
                "lastTransitionTime": "2024-08-15T02:15:59Z",
                "status": "True",
                "type": "PodScheduled"
            }
        ],
        "containerStatuses": [
            {
                "containerID": "containerd://a2be9e2f96b612050e1247445232ccb44142fe829306247ed35a52e70cb56282",
                "image": "docker.io/library/nginx:latest",
                "imageID": "docker.io/library/nginx@sha256:98f8ec75657d21b924fe4f69b6b9bff2f6550ea48838af479d8894a852000e40",
                "lastState": {},
                "name": "bee",
                "ready": true,
                "restartCount": 0,
                "started": true,
                "state": {
                    "running": {
                        "startedAt": "2024-08-15T02:16:06Z"
                    }
                }
            }
        ],
        "hostIP": "192.3.235.3",
        "hostIPs": [
            {
                "ip": "192.3.235.3"
            }
        ],
        "phase": "Running",
        "podIP": "10.244.1.2",
        "podIPs": [
            {
                "ip": "10.244.1.2"
            }
        ],
        "qosClass": "BestEffort",
        "startTime": "2024-08-15T02:15:59Z"
    }
}

controlplane ~ ➜  kubectl get pod/bee -o json | grep node
        "nodeName": "node01",
                "key": "node.kubernetes.io/not-ready",
                "key": "node.kubernetes.io/unreachable",

controlplane ~ ➜  kubectl get node/controlplane -o json | grep -t taint
grep: invalid option -- 't'
Usage: grep [OPTION]... PATTERNS [FILE]...
Try 'grep --help' for more information.

controlplane ~ ✖ kubectl get node/controlplane -o json | grep -i taint
        "taints": [

controlplane ~ ➜  kubectl get node/controlplane -o json | grep -i taint -n5
28-    "spec": {
29-        "podCIDR": "10.244.0.0/24",
30-        "podCIDRs": [
31-            "10.244.0.0/24"
32-        ],
33:        "taints": [
34-            {
35-                "effect": "NoSchedule",
36-                "key": "node-role.kubernetes.io/control-plane"
37-            }
38-        ]

controlplane ~ ➜  kubectl edit node controlplane
node/controlplane edited

controlplane ~ ➜  kubectl get pod/mosquito
NAME       READY   STATUS    RESTARTS   AGE
mosquito   1/1     Running   0          10m

controlplane ~ ➜  kubectl get pod/mosquito -o json | grep -i nodeName -n 5 
grep: 5: No such file or directory

controlplane ~ ✖ kubectl get pod/mosquito -o json | grep -n5 -i nodeName  
29-                ]
30-            }
31-        ],
32-        "dnsPolicy": "ClusterFirst",
33-        "enableServiceLinks": true,
34:        "nodeName": "controlplane",
35-        "preemptionPolicy": "PreemptLowerPriority",
36-        "priority": 0,
37-        "restartPolicy": "Always",
38-        "schedulerName": "default-scheduler",
39-        "securityContext": {},

controlplane ~ ➜  

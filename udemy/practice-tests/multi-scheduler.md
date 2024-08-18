       Welcome to the KodeKloud Hands-On lab                                                                         
    __ ______  ____  ________ __ __    ____  __  ______ 
   / //_/ __ \/ __ \/ ____/ //_// /   / __ \/ / / / __ \
  / ,< / / / / / / / __/ / ,<  / /   / / / / / / / / / /
 / /| / /_/ / /_/ / /___/ /| |/ /___/ /_/ / /_/ / /_/ / 
/_/ |_\____/_____/_____/_/ |_/_____/\____/\____/_____/  
                                                        
            All rights reserved                                                                                      

controlplane ~ ➜  kubect get pods --all-namespaces
-bash: kubect: command not found

controlplane ~ ✖ kubectl get pods --all-namespaces
NAMESPACE      NAME                                   READY   STATUS    RESTARTS   AGE
kube-flannel   kube-flannel-ds-bql7b                  1/1     Running   0          7m45s
kube-system    coredns-768b85b76f-tsfkc               1/1     Running   0          7m45s
kube-system    coredns-768b85b76f-x5fww               1/1     Running   0          7m45s
kube-system    etcd-controlplane                      1/1     Running   0          7m58s
kube-system    kube-apiserver-controlplane            1/1     Running   0          7m58s
kube-system    kube-controller-manager-controlplane   1/1     Running   0          7m58s
kube-system    kube-proxy-4pp92                       1/1     Running   0          7m45s
kube-system    kube-scheduler-controlplane            1/1     Running   0          7m58s

controlplane ~ ➜  kubectl get pod/kube-scheduler-controlplane  -o wide
Error from server (NotFound): pods "kube-scheduler-controlplane" not found

controlplane ~ ✖ kubectl get pod/kube-scheduler-controlplane  -o wide --namespace=kube-system
NAME                          READY   STATUS    RESTARTS   AGE     IP            NODE           NOMINATED NODE   READINESS GATES
kube-scheduler-controlplane   1/1     Running   0          9m29s   192.34.24.3   controlplane   <none>           <none>

controlplane ~ ➜  kubectl get pod/kube-scheduler-controlplane  -o json --namespace=kube-system
{
    "apiVersion": "v1",
    "kind": "Pod",
    "metadata": {
        "annotations": {
            "kubernetes.io/config.hash": "db172d5b3add27a8cc689d10fd0e2f4c",
            "kubernetes.io/config.mirror": "db172d5b3add27a8cc689d10fd0e2f4c",
            "kubernetes.io/config.seen": "2024-08-15T16:43:52.869160105Z",
            "kubernetes.io/config.source": "file"
        },
        "creationTimestamp": "2024-08-15T16:43:53Z",
        "labels": {
            "component": "kube-scheduler",
            "tier": "control-plane"
        },
        "name": "kube-scheduler-controlplane",
        "namespace": "kube-system",
        "ownerReferences": [
            {
                "apiVersion": "v1",
                "controller": true,
                "kind": "Node",
                "name": "controlplane",
                "uid": "d2a4efd0-4153-42f5-a84a-c75ef98aa8ab"
            }
        ],
        "resourceVersion": "307",
        "uid": "01942deb-9382-4004-9649-311829a0f17f"
    },
    "spec": {
        "containers": [
            {
                "command": [
                    "kube-scheduler",
                    "--authentication-kubeconfig=/etc/kubernetes/scheduler.conf",
                    "--authorization-kubeconfig=/etc/kubernetes/scheduler.conf",
                    "--bind-address=127.0.0.1",
                    "--kubeconfig=/etc/kubernetes/scheduler.conf",
                    "--leader-elect=true"
                ],
                "image": "registry.k8s.io/kube-scheduler:v1.30.0",
                "imagePullPolicy": "IfNotPresent",
                "livenessProbe": {
                    "failureThreshold": 8,
                    "httpGet": {
                        "host": "127.0.0.1",
                        "path": "/healthz",
                        "port": 10259,
                        "scheme": "HTTPS"
                    },
                    "initialDelaySeconds": 10,
                    "periodSeconds": 10,
                    "successThreshold": 1,
                    "timeoutSeconds": 15
                },
                "name": "kube-scheduler",
                "resources": {
                    "requests": {
                        "cpu": "100m"
                    }
                },
                "startupProbe": {
                    "failureThreshold": 24,
                    "httpGet": {
                        "host": "127.0.0.1",
                        "path": "/healthz",
                        "port": 10259,
                        "scheme": "HTTPS"
                    },
                    "initialDelaySeconds": 10,
                    "periodSeconds": 10,
                    "successThreshold": 1,
                    "timeoutSeconds": 15
                },
                "terminationMessagePath": "/dev/termination-log",
                "terminationMessagePolicy": "File",
                "volumeMounts": [
                    {
                        "mountPath": "/etc/kubernetes/scheduler.conf",
                        "name": "kubeconfig",
                        "readOnly": true
                    }
                ]
            }
        ],
        "dnsPolicy": "ClusterFirst",
        "enableServiceLinks": true,
        "hostNetwork": true,
        "nodeName": "controlplane",
        "preemptionPolicy": "PreemptLowerPriority",
        "priority": 2000001000,
        "priorityClassName": "system-node-critical",
        "restartPolicy": "Always",
        "schedulerName": "default-scheduler",
        "securityContext": {
            "seccompProfile": {
                "type": "RuntimeDefault"
            }
        },
        "terminationGracePeriodSeconds": 30,
        "tolerations": [
            {
                "effect": "NoExecute",
                "operator": "Exists"
            }
        ],
        "volumes": [
            {
                "hostPath": {
                    "path": "/etc/kubernetes/scheduler.conf",
                    "type": "FileOrCreate"
                },
                "name": "kubeconfig"
            }
        ]
    },
    "status": {
        "conditions": [
            {
                "lastProbeTime": null,
                "lastTransitionTime": "2024-08-15T16:43:53Z",
                "status": "True",
                "type": "PodReadyToStartContainers"
            },
            {
                "lastProbeTime": null,
                "lastTransitionTime": "2024-08-15T16:43:53Z",
                "status": "True",
                "type": "Initialized"
            },
            {
                "lastProbeTime": null,
                "lastTransitionTime": "2024-08-15T16:44:04Z",
                "status": "True",
                "type": "Ready"
            },
            {
                "lastProbeTime": null,
                "lastTransitionTime": "2024-08-15T16:44:04Z",
                "status": "True",
                "type": "ContainersReady"
            },
            {
                "lastProbeTime": null,
                "lastTransitionTime": "2024-08-15T16:43:53Z",
                "status": "True",
                "type": "PodScheduled"
            }
        ],
        "containerStatuses": [
            {
                "containerID": "containerd://3879ef84332c8365cd4acee6d88d45ef8b704ec75054a6286d27b2d61e584ccd",
                "image": "registry.k8s.io/kube-scheduler:v1.30.0",
                "imageID": "registry.k8s.io/kube-scheduler@sha256:2353c3a1803229970fcb571cffc9b2f120372350e01c7381b4b650c4a02b9d67",
                "lastState": {},
                "name": "kube-scheduler",
                "ready": true,
                "restartCount": 0,
                "started": true,
                "state": {
                    "running": {
                        "startedAt": "2024-08-15T16:43:44Z"
                    }
                }
            }
        ],
        "hostIP": "192.34.24.3",
        "hostIPs": [
            {
                "ip": "192.34.24.3"
            }
        ],
        "phase": "Running",
        "podIP": "192.34.24.3",
        "podIPs": [
            {
                "ip": "192.34.24.3"
            }
        ],
        "qosClass": "Burstable",
        "startTime": "2024-08-15T16:43:53Z"
    }
}

controlplane ~ ➜  kubectl get pod/my-scheduler  -o json --namespace=kube-system
Error from server (NotFound): pods "my-scheduler" not found

controlplane ~ ✖ kubectl get sa/my-scheduler  -o json --namespace=kube-system
{
    "apiVersion": "v1",
    "kind": "ServiceAccount",
    "metadata": {
        "creationTimestamp": "2024-08-15T16:53:58Z",
        "name": "my-scheduler",
        "namespace": "kube-system",
        "resourceVersion": "1197",
        "uid": "ae772dbe-e17b-46bc-9c1f-c267446e72c8"
    }
}

controlplane ~ ➜  kubectl get crb  --namespace=kube-system
error: the server doesn't have a resource type "crb"

controlplane ~ ✖ kubectl get clusterrolebinding
NAME                                                            ROLE                                                                               AGE
cluster-admin                                                   ClusterRole/cluster-admin                                                          13m
flannel                                                         ClusterRole/flannel                                                                13m
kubeadm:cluster-admins                                          ClusterRole/cluster-admin                                                          13m
kubeadm:get-nodes                                               ClusterRole/kubeadm:get-nodes                                                      13m
kubeadm:kubelet-bootstrap                                       ClusterRole/system:node-bootstrapper                                               13m
kubeadm:node-autoapprove-bootstrap                              ClusterRole/system:certificates.k8s.io:certificatesigningrequests:nodeclient       13m
kubeadm:node-autoapprove-certificate-rotation                   ClusterRole/system:certificates.k8s.io:certificatesigningrequests:selfnodeclient   13m
kubeadm:node-proxier                                            ClusterRole/system:node-proxier                                                    13m
my-scheduler-as-kube-scheduler                                  ClusterRole/system:kube-scheduler                                                  3m14s
my-scheduler-as-volume-scheduler                                ClusterRole/system:volume-scheduler                                                3m14s
system:basic-user                                               ClusterRole/system:basic-user                                                      13m
system:controller:attachdetach-controller                       ClusterRole/system:controller:attachdetach-controller                              13m
system:controller:certificate-controller                        ClusterRole/system:controller:certificate-controller                               13m
system:controller:clusterrole-aggregation-controller            ClusterRole/system:controller:clusterrole-aggregation-controller                   13m
system:controller:cronjob-controller                            ClusterRole/system:controller:cronjob-controller                                   13m
system:controller:daemon-set-controller                         ClusterRole/system:controller:daemon-set-controller                                13m
system:controller:deployment-controller                         ClusterRole/system:controller:deployment-controller                                13m
system:controller:disruption-controller                         ClusterRole/system:controller:disruption-controller                                13m
system:controller:endpoint-controller                           ClusterRole/system:controller:endpoint-controller                                  13m
system:controller:endpointslice-controller                      ClusterRole/system:controller:endpointslice-controller                             13m
system:controller:endpointslicemirroring-controller             ClusterRole/system:controller:endpointslicemirroring-controller                    13m
system:controller:ephemeral-volume-controller                   ClusterRole/system:controller:ephemeral-volume-controller                          13m
system:controller:expand-controller                             ClusterRole/system:controller:expand-controller                                    13m
system:controller:generic-garbage-collector                     ClusterRole/system:controller:generic-garbage-collector                            13m
system:controller:horizontal-pod-autoscaler                     ClusterRole/system:controller:horizontal-pod-autoscaler                            13m
system:controller:job-controller                                ClusterRole/system:controller:job-controller                                       13m
system:controller:legacy-service-account-token-cleaner          ClusterRole/system:controller:legacy-service-account-token-cleaner                 13m
system:controller:namespace-controller                          ClusterRole/system:controller:namespace-controller                                 13m
system:controller:node-controller                               ClusterRole/system:controller:node-controller                                      13m
system:controller:persistent-volume-binder                      ClusterRole/system:controller:persistent-volume-binder                             13m
system:controller:pod-garbage-collector                         ClusterRole/system:controller:pod-garbage-collector                                13m
system:controller:pv-protection-controller                      ClusterRole/system:controller:pv-protection-controller                             13m
system:controller:pvc-protection-controller                     ClusterRole/system:controller:pvc-protection-controller                            13m
system:controller:replicaset-controller                         ClusterRole/system:controller:replicaset-controller                                13m
system:controller:replication-controller                        ClusterRole/system:controller:replication-controller                               13m
system:controller:resourcequota-controller                      ClusterRole/system:controller:resourcequota-controller                             13m
system:controller:root-ca-cert-publisher                        ClusterRole/system:controller:root-ca-cert-publisher                               13m
system:controller:route-controller                              ClusterRole/system:controller:route-controller                                     13m
system:controller:service-account-controller                    ClusterRole/system:controller:service-account-controller                           13m
system:controller:service-controller                            ClusterRole/system:controller:service-controller                                   13m
system:controller:statefulset-controller                        ClusterRole/system:controller:statefulset-controller                               13m
system:controller:ttl-after-finished-controller                 ClusterRole/system:controller:ttl-after-finished-controller                        13m
system:controller:ttl-controller                                ClusterRole/system:controller:ttl-controller                                       13m
system:controller:validatingadmissionpolicy-status-controller   ClusterRole/system:controller:validatingadmissionpolicy-status-controller          13m
system:coredns                                                  ClusterRole/system:coredns                                                         13m
system:discovery                                                ClusterRole/system:discovery                                                       13m
system:kube-controller-manager                                  ClusterRole/system:kube-controller-manager                                         13m
system:kube-dns                                                 ClusterRole/system:kube-dns                                                        13m
system:kube-scheduler                                           ClusterRole/system:kube-scheduler                                                  13m
system:monitoring                                               ClusterRole/system:monitoring                                                      13m
system:node                                                     ClusterRole/system:node                                                            13m
system:node-proxier                                             ClusterRole/system:node-proxier                                                    13m
system:public-info-viewer                                       ClusterRole/system:public-info-viewer                                              13m
system:service-account-issuer-discovery                         ClusterRole/system:service-account-issuer-discovery                                13m
system:volume-scheduler                                         ClusterRole/system:volume-scheduler                                                13m

controlplane ~ ➜  cat my-scheduler-configmap.yaml
apiVersion: v1
data:
  my-scheduler-config.yaml: |
    apiVersion: kubescheduler.config.k8s.io/v1
    kind: KubeSchedulerConfiguration
    profiles:
      - schedulerName: my-scheduler
    leaderElection:
      leaderElect: false
kind: ConfigMap
metadata:
  creationTimestamp: null
  name: my-scheduler-config
  namespace: kube-system


controlplane ~ ➜  kubectl create -f /root/my-scheduler-config.yaml
error: resource mapping not found for name: "" namespace: "" from "/root/my-scheduler-config.yaml": no matches for kind "KubeSchedulerConfiguration" in version "kubescheduler.config.k8s.io/v1"
ensure CRDs are installed first

controlplane ~ ✖ kubectl create -f my-scheduler-configmap.yaml
configmap/my-scheduler-config created

controlplane ~ ➜  cat /root/my-scheduler.yaml
apiVersion: v1
kind: Pod
metadata:
  labels:
    run: my-scheduler
  name: my-scheduler
  namespace: kube-system
spec:
  serviceAccountName: my-scheduler
  containers:
  - command:
    - /usr/local/bin/kube-scheduler
    - --config=/etc/kubernetes/my-scheduler/my-scheduler-config.yaml
    image: <use-correct-image>
    livenessProbe:
      httpGet:
        path: /healthz
        port: 10259
        scheme: HTTPS
      initialDelaySeconds: 15
    name: kube-second-scheduler
    readinessProbe:
      httpGet:
        path: /healthz
        port: 10259
        scheme: HTTPS
    resources:
      requests:
        cpu: '0.1'
    securityContext:
      privileged: false
    volumeMounts:
      - name: config-volume
        mountPath: /etc/kubernetes/my-scheduler
  hostNetwork: false
  hostPID: false
  volumes:
    - name: config-volume
      configMap:
        name: my-scheduler-config

controlplane ~ ➜  kubectl create -f /root/my-scheduler.yaml
pod/my-scheduler created

controlplane ~ ➜  kubectl get pods --all-namespaces -o wide
NAMESPACE      NAME                                   READY   STATUS             RESTARTS   AGE     IP            NODE           NOMINATED NODE   READINESS GATES
kube-flannel   kube-flannel-ds-bql7b                  1/1     Running            0          49m     192.34.24.3   controlplane   <none>           <none>
kube-system    coredns-768b85b76f-tsfkc               1/1     Running            0          49m     10.244.0.2    controlplane   <none>           <none>
kube-system    coredns-768b85b76f-x5fww               1/1     Running            0          49m     10.244.0.3    controlplane   <none>           <none>
kube-system    etcd-controlplane                      1/1     Running            0          50m     192.34.24.3   controlplane   <none>           <none>
kube-system    kube-apiserver-controlplane            1/1     Running            0          50m     192.34.24.3   controlplane   <none>           <none>
kube-system    kube-controller-manager-controlplane   1/1     Running            0          50m     192.34.24.3   controlplane   <none>           <none>
kube-system    kube-proxy-4pp92                       1/1     Running            0          49m     192.34.24.3   controlplane   <none>           <none>
kube-system    kube-scheduler-controlplane            1/1     Running            0          50m     192.34.24.3   controlplane   <none>           <none>
kube-system    my-scheduler                           0/1     InvalidImageName   0          2m19s   10.244.0.4    controlplane   <none>           <none>

controlplane ~ ➜  kubectl get kube-scheduler-controlplane    -o json
error: the server doesn't have a resource type "kube-scheduler-controlplane"

controlplane ~ ✖ kubectl get kube-scheduler-controlplane    -o json -n kube-system 
error: the server doesn't have a resource type "kube-scheduler-controlplane"

controlplane ~ ✖ kubectl get pod/kube-scheduler-controlplane    -o json -n kube-system 
{
    "apiVersion": "v1",
    "kind": "Pod",
    "metadata": {
        "annotations": {
            "kubernetes.io/config.hash": "db172d5b3add27a8cc689d10fd0e2f4c",
            "kubernetes.io/config.mirror": "db172d5b3add27a8cc689d10fd0e2f4c",
            "kubernetes.io/config.seen": "2024-08-15T16:43:52.869160105Z",
            "kubernetes.io/config.source": "file"
        },
        "creationTimestamp": "2024-08-15T16:43:53Z",
        "labels": {
            "component": "kube-scheduler",
            "tier": "control-plane"
        },
        "name": "kube-scheduler-controlplane",
        "namespace": "kube-system",
        "ownerReferences": [
            {
                "apiVersion": "v1",
                "controller": true,
                "kind": "Node",
                "name": "controlplane",
                "uid": "d2a4efd0-4153-42f5-a84a-c75ef98aa8ab"
            }
        ],
        "resourceVersion": "307",
        "uid": "01942deb-9382-4004-9649-311829a0f17f"
    },
    "spec": {
        "containers": [
            {
                "command": [
                    "kube-scheduler",
                    "--authentication-kubeconfig=/etc/kubernetes/scheduler.conf",
                    "--authorization-kubeconfig=/etc/kubernetes/scheduler.conf",
                    "--bind-address=127.0.0.1",
                    "--kubeconfig=/etc/kubernetes/scheduler.conf",
                    "--leader-elect=true"
                ],
                "image": "registry.k8s.io/kube-scheduler:v1.30.0",
                "imagePullPolicy": "IfNotPresent",
                "livenessProbe": {
                    "failureThreshold": 8,
                    "httpGet": {
                        "host": "127.0.0.1",
                        "path": "/healthz",
                        "port": 10259,
                        "scheme": "HTTPS"
                    },
                    "initialDelaySeconds": 10,
                    "periodSeconds": 10,
                    "successThreshold": 1,
                    "timeoutSeconds": 15
                },
                "name": "kube-scheduler",
                "resources": {
                    "requests": {
                        "cpu": "100m"
                    }
                },
                "startupProbe": {
                    "failureThreshold": 24,
                    "httpGet": {
                        "host": "127.0.0.1",
                        "path": "/healthz",
                        "port": 10259,
                        "scheme": "HTTPS"
                    },
                    "initialDelaySeconds": 10,
                    "periodSeconds": 10,
                    "successThreshold": 1,
                    "timeoutSeconds": 15
                },
                "terminationMessagePath": "/dev/termination-log",
                "terminationMessagePolicy": "File",
                "volumeMounts": [
                    {
                        "mountPath": "/etc/kubernetes/scheduler.conf",
                        "name": "kubeconfig",
                        "readOnly": true
                    }
                ]
            }
        ],
        "dnsPolicy": "ClusterFirst",
        "enableServiceLinks": true,
        "hostNetwork": true,
        "nodeName": "controlplane",
        "preemptionPolicy": "PreemptLowerPriority",
        "priority": 2000001000,
        "priorityClassName": "system-node-critical",
        "restartPolicy": "Always",
        "schedulerName": "default-scheduler",
        "securityContext": {
            "seccompProfile": {
                "type": "RuntimeDefault"
            }
        },
        "terminationGracePeriodSeconds": 30,
        "tolerations": [
            {
                "effect": "NoExecute",
                "operator": "Exists"
            }
        ],
        "volumes": [
            {
                "hostPath": {
                    "path": "/etc/kubernetes/scheduler.conf",
                    "type": "FileOrCreate"
                },
                "name": "kubeconfig"
            }
        ]
    },
    "status": {
        "conditions": [
            {
                "lastProbeTime": null,
                "lastTransitionTime": "2024-08-15T16:43:53Z",
                "status": "True",
                "type": "PodReadyToStartContainers"
            },
            {
                "lastProbeTime": null,
                "lastTransitionTime": "2024-08-15T16:43:53Z",
                "status": "True",
                "type": "Initialized"
            },
            {
                "lastProbeTime": null,
                "lastTransitionTime": "2024-08-15T16:44:04Z",
                "status": "True",
                "type": "Ready"
            },
            {
                "lastProbeTime": null,
                "lastTransitionTime": "2024-08-15T16:44:04Z",
                "status": "True",
                "type": "ContainersReady"
            },
            {
                "lastProbeTime": null,
                "lastTransitionTime": "2024-08-15T16:43:53Z",
                "status": "True",
                "type": "PodScheduled"
            }
        ],
        "containerStatuses": [
            {
                "containerID": "containerd://3879ef84332c8365cd4acee6d88d45ef8b704ec75054a6286d27b2d61e584ccd",
                "image": "registry.k8s.io/kube-scheduler:v1.30.0",
                "imageID": "registry.k8s.io/kube-scheduler@sha256:2353c3a1803229970fcb571cffc9b2f120372350e01c7381b4b650c4a02b9d67",
                "lastState": {},
                "name": "kube-scheduler",
                "ready": true,
                "restartCount": 0,
                "started": true,
                "state": {
                    "running": {
                        "startedAt": "2024-08-15T16:43:44Z"
                    }
                }
            }
        ],
        "hostIP": "192.34.24.3",
        "hostIPs": [
            {
                "ip": "192.34.24.3"
            }
        ],
        "phase": "Running",
        "podIP": "192.34.24.3",
        "podIPs": [
            {
                "ip": "192.34.24.3"
            }
        ],
        "qosClass": "Burstable",
        "startTime": "2024-08-15T16:43:53Z"
    }
}

controlplane ~ ➜  vi  /root/my-scheduler.yaml

controlplane ~ ➜  kubectl replace -f  /root/my-scheduler.yaml
The Pod "my-scheduler" is invalid: spec: Forbidden: pod updates may not change fields other than `spec.containers[*].image`,`spec.initContainers[*].image`,`spec.activeDeadlineSeconds`,`spec.tolerations` (only additions to existing tolerations),`spec.terminationGracePeriodSeconds` (allow it to be set to 1 if it was previously negative)
  core.PodSpec{
        Volumes: []core.Volume{
                {Name: "config-volume", VolumeSource: {ConfigMap: &{LocalObjectReference: {Name: "my-scheduler-config"}, DefaultMode: &420}}},
-               {
-                       Name: "kube-api-access-kv9ml",
-                       VolumeSource: core.VolumeSource{
-                               Projected: &core.ProjectedVolumeSource{Sources: []core.VolumeProjection{...}, DefaultMode: &420},
-                       },
-               },
        },
        InitContainers: nil,
        Containers: []core.Container{
                {
                        ... // 9 identical fields
                        ResizePolicy:  nil,
                        RestartPolicy: nil,
                        VolumeMounts: []core.VolumeMount{
                                {Name: "config-volume", MountPath: "/etc/kubernetes/my-scheduler"},
-                               {
-                                       Name:      "kube-api-access-kv9ml",
-                                       ReadOnly:  true,
-                                       MountPath: "/var/run/secrets/kubernetes.io/serviceaccount",
-                               },
                        },
                        VolumeDevices: nil,
                        LivenessProbe: &{ProbeHandler: {HTTPGet: &{Path: "/healthz", Port: {IntVal: 10259}, Scheme: "HTTPS"}}, InitialDelaySeconds: 15, TimeoutSeconds: 1, PeriodSeconds: 10, ...},
                        ... // 10 identical fields
                },
        },
        EphemeralContainers: nil,
        RestartPolicy:       "Always",
        ... // 4 identical fields
        ServiceAccountName:           "my-scheduler",
        AutomountServiceAccountToken: nil,
-       NodeName:                     "controlplane",
+       NodeName:                     "",
        SecurityContext:              &{},
        ImagePullSecrets:             nil,
        ... // 19 identical fields
  }


controlplane ~ ✖ kubectl delete pod/my-scheduler   --force --grace-period=0
Warning: Immediate deletion does not wait for confirmation that the running resource has been terminated. The resource may continue to run on the cluster indefinitely.
Error from server (NotFound): pods "my-scheduler" not found

controlplane ~ ✖ kubectl delete pod/my-scheduler   --force --grace-period=0 --namespace=kube-system    
Warning: Immediate deletion does not wait for confirmation that the running resource has been terminated. The resource may continue to run on the cluster indefinitely.
pod "my-scheduler" force deleted

controlplane ~ ➜  kubectl create -f  /root/my-scheduler.yaml
pod/my-scheduler created

controlplane ~ ➜  vi /root/nginx-pod.yaml

controlplane ~ ➜  kubectl create -f  /root/nginx-pod.yaml
pod/nginx created

controlplane ~ ➜  

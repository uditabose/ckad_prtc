#!/bin/bash

kubectl create -f ch1-nginx.yaml
#----------------
# pod/nginx created


<<taskdescription
1. Output the cluster configuration, with contexts and users and the
API server address. Save the output to a file named config.yaml and
share the link to your file.
taskdescription
#----------------
kubectl config view

#----------------
# apiVersion: v1
# clusters:
# - cluster:
#     certificate-authority-data: DATA+OMITTED
#     server: https://kubernetes.docker.internal:6443
#   name: docker-desktop
# contexts:
# - context:
#     cluster: docker-desktop
#     user: docker-desktop
#   name: docker-desktop
# current-context: docker-desktop
# kind: Config
# preferences: {}
# users:
# - name: docker-desktop
#   user:
#     client-certificate-data: REDACTED
#     client-key-data: REDACTED


<<taskdescription
2. Use the command that lists where the Kubernetes control plane and c
oreDNS is running, including their full API resource location.
Save the output to a file named running.txt and share the link to your file.
taskdescription
#----------------
kubectl cluster-info --context kind-kind

<<output
Kubernetes control plane is running at https://127.0.0.1:63073
CoreDNS is running at https://127.0.0.1:63073/api/v1/namespaces/kube-system/services/kube-dns:dns/proxy

To further debug and diagnose cluster problems, use 'kubectl cluster-info dump'.
output

#----------------
<<taskdescription
3. Perform the command to list all API resources in your Kubernetes cluster.
Save the output to a file named “resources.csv” and share a link to your file.
taskdescription
#----------------
kubectl api-resources > acing/ch1-basic/api-resources.txt


<<taskdescription
4. List the contents of the directory where client and server certificates
are stored using the `ls` command. Save the output of the `ls` command to
a file named certificates.txt and share the link to your file.
taskdescription
#----------------

<<taskdescription
5. List the services on your linux system that are associated with Kubernetes.
Save the output to a file named services.csv and share the link to your file.
HINT: There are three services.
taskdescription
#----------------

<<taskdescription
6. Use the CLI tool that will allow you to output the logs of the kubelet service.
Output the logs to a file named logs.txt and share the link to your file.
taskdescription
#----------------

<<taskdescription
7. Access the Kubernetes raw API endpoint using curl. Save the output to a file named
api-curl.json and share the link to your file.
HINT: First, create a new clusterrole named “view-binding” with the command
```
kubectl create clusterrolebinding view-binding --clusterrole=view --serviceaccount=kube-system:default
```
and to view the secret of the default service account, list the YAML via the command
```
kubectl get sa default -o yaml -n kube-system
```
Once you have the secret name, you can output the yaml to view the token with the command
```
kubectl get secret default-token-fzls7 -n kube-system -o yaml
```
(default-token-fzls7 is the name of my secret, but yours will be different).
Then, copy the token, save it into an environment variable named TOKEN
and base64 decode it with the command
`TOKEN='6IlJ6czFud2llb3pKN05hUDh2Q3VNeDRXNWJ3eUhFczh0TW' | base64 -d`.
Next, you can get the output of
`kubectl config view`
and copy the server address (mine is `https://kind-control-plane:6443`).
Save that in an environment variable named “SERVER”.
Now you can use curl to access the Kubernetes API with the command
`curl -X GET $SERVER/api --header "Authorization: Bearer $TOKEN" -- cacert /etc/kubernetes/pki/ca.crt`
taskdescription
#----------------
 curl -k https://127.0.0.1:63073

<<output
{
  "kind": "Status",
  "apiVersion": "v1",
  "metadata": {},
  "status": "Failure",
  "message": "forbidden: User \"system:anonymous\" cannot get path \"/\"",
  "reason": "Forbidden",
  "details": {},
  "code": 403
}%
output

<<output
 kubectl get sa default -o yaml -n kube-system
apiVersion: v1
kind: ServiceAccount
metadata:
  creationTimestamp: "2023-01-15T18:20:50Z"
  name: default
  namespace: kube-system
  resourceVersion: "358"
  uid: bd1ad1aa-5bdd-4f43-bd84-ce044e1351ea
output

<<output
 kubectl create clusterrolebinding view-binding --clusterrole=view --serviceaccount=kube-system:default
clusterrolebinding.rbac.authorization.k8s.io/view-binding created
output

<<taskdescription
8. Use the `kubectl create` command to create a deployment in Kubernetes.
Save the YAML file as chap1-deploy.yaml and share the link to your file.
taskdescription
#----------------




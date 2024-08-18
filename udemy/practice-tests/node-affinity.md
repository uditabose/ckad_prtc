
controlplane ~ ➜  kubectl edit node node01
error: nodes "node01" is invalid
error: nodes "node01" is invalid
A copy of your changes has been stored to "/tmp/kubectl-edit-2115181870.yaml"
error: Edit cancelled, no valid changes were saved.

controlplane ~ ✖ kubectl get node node01 -o yaml > node01.yaml

controlplane ~ ➜  kubectl get deployments
NAME   READY   UP-TO-DATE   AVAILABLE   AGE
blue   3/3     3            3           12m

controlplane ~ ➜  kubectl edit blue
error: the server doesn't have a resource type "blue"

controlplane ~ ✖ kubectl edit deployment/blue
error: deployments.apps "blue" is invalid
deployment.apps/blue edited

controlplane ~ ➜  kubectl get pods
NAME                   READY   STATUS    RESTARTS   AGE
blue-884849b5b-4hfn4   1/1     Running   0          34s
blue-884849b5b-h9zqw   1/1     Running   0          36s
blue-884849b5b-sfmrj   1/1     Running   0          37s

controlplane ~ ➜  kubectl get pods/blue-884849b5b-4hfn4  -o json | grep nodeName
        "nodeName": "node01",

controlplane ~ ➜  kubectl get pods/blue-884849b5b-h9zqw  -o json | grep nodeName
        "nodeName": "node01",

controlplane ~ ➜  kubectl get pods/blue-884849b5b-sfmrj   -o json | grep nodeName
        "nodeName": "node01",

controlplane ~ ➜  kubectl create deployment red --image=nginx
deployment.apps/red created

controlplane ~ ➜  kubectl edit deployment.apps/red
deployment.apps/red edited

controlplane ~ ➜  



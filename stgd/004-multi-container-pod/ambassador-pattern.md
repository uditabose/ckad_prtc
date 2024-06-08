# Ambassador Pattern

Provides proxy for communicating with external services.
Examples - 

- retry logic upon request of failure
- authentication and authorization
- monitoring latency or resource usage

## Table of Content  <!-- omit in toc -->

- [Ambassador Pattern](#ambassador-pattern)
  - [Rate limiter pod](#rate-limiter-pod)
    - [Verify](#verify)
  - [Teardown](#teardown)


## Rate limiter pod

```bash
kubectl create -f stgd/004-multi-container-pod/ambassador-pattern/ratelimiter-pod.yaml
pod/rate-limiter created
```

### Verify

```bash
kubectl get pod/rate-limiter -o json > stgd/004-multi-container-pod/ambassador-pattern/ratelimiter-pod-dump.json
```

```bash
kubectl exec rate-limiter -it -c business-app -- /bin/sh                                                                                                                          [22:45:09]
# curl localhost:9091/test                       
curl: (7) Failed to connect to localhost port 9091: Connection refused
# curl localhost:9090/test                
curl: (7) Failed to connect to localhost port 9090: Connection refused
# curl localhost:8080/test 
{
  "args": {
    "test": "123"
  },
  "headers": {
    "x-forwarded-proto": "https",
    "x-forwarded-port": "443",
    "host": "postman-echo.com",
    "x-amzn-trace-id": "Root=1-6663c62d-67fdd864433744f63a4f4d73"
  },
  "url": "https://postman-echo.com/get?test=123"
}# curl localhost:9090/test  
curl: (7) Failed to connect to localhost port 9090: Connection refused
# curl localhost:8080/test
{
  "args": {
    "test": "123"
  },
  "headers": {
    "x-forwarded-proto": "https",
    "x-forwarded-port": "443",
    "host": "postman-echo.com",
    "x-amzn-trace-id": "Root=1-6663c63c-14a824ba605758522b068fb3"
  },
  "url": "https://postman-echo.com/get?test=123"
}# 
```

after a few execution

```bash
# curl localhost:8080/test
Too many requests made created from this IP, please try again after an hour# 
```

## Teardown

```bash
kubectl delete pod/rate-limiter --force --grace-period=0
---
Warning: Immediate deletion does not wait for confirmation that the running resource has been terminated. The resource may continue to run on the cluster indefinitely.
pod "rate-limiter" force deleted
 
```

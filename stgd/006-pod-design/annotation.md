# Annotation

Key-value pair to add metadata. Can't bet used in query.

## Table of Content  <!-- omit in toc -->

- [Annotation](#annotation)
  - [Declare Annotation](#declare-annotation)
    - [Inspect pod with annotation](#inspect-pod-with-annotation)
  - [Modify annotation](#modify-annotation)

## Declare Annotation

```bash
kubectl create -f stgd/006-pod-design/annotation/anotated-pod.yaml
pod/annotated-pod created
```

### Inspect pod with annotation

```bash
kubectl describe pod/annotated-pod > stgd/006-pod-design/annotation/anotated-pod-desc.txt
```

> AND

```bash
kubectl get pod/annotated-pod -o json | jq .metadata.annotations
{
  "author": "Papa Bosu",
  "branch": "ckad_prtc/main",
  "commit": "3ba0d44"
}
```


## Modify annotation

```bash
kubectl annotate pod annotated-pod oncall='800-555-1212'
pod/annotated-pod annotated
---

kubectl annotate pod annotated-pod oncall='800-555-2020' --overwrite
pod/annotated-pod annotated

---

kubectl annotate pod annotated-pod oncall-
---
kubectl get pod/annotated-pod -o json | jq .metadata.annotations
{
  "author": "Papa Bosu",
  "branch": "ckad_prtc/main",
  "commit": "3ba0d44"
}
```

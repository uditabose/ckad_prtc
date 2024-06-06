# Multi-Container Pods

## Table of Content  <!-- omit in toc -->

- [Multi-Container Pods](#multi-container-pods)
  - [Summary](#summary)
    - [Design guidance](#design-guidance)
  - [Init Container](#init-container)

## Summary

Following concepts are covered

- Pod
- Container
- Volume
- Design Patterns

### Design guidance

- Run a single microservice in a Pod.
- A init container may run start-up commands.
- A `sidecar` container can run helper functions, example is log messages.

## Init Container

- If any init cont fails, whole Pod is restarted
- make init conts idempotent

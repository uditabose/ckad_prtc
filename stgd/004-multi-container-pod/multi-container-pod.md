# Multi-Container Pods

## Table of Content  <!-- omit in toc -->

- [Multi-Container Pods](#multi-container-pods)
  - [Summary](#summary)
    - [3 patterns](#3-patterns)
      - [Sidecar pattern](#sidecar-pattern)
      - [Ambassador pattern](#ambassador-pattern)
      - [Adapter pattern](#adapter-pattern)
    - [Design guidance](#design-guidance)
  - [Init Container](#init-container)
  - [Details](#details)

## Summary

Following concepts are covered

- Pod
- Container
- Volume
- Design Patterns

### 3 patterns

Multi-container design patterns

#### Sidecar pattern

An extra container in your pod to enhance or extend the functionality of the main container.

#### Ambassador pattern

A container that proxy the network connection to the main container.

#### Adapter pattern

A container that transform output of the main container.

### Design guidance

- Run a single microservice in a Pod.
- A init container may run start-up commands.
- A `sidecar` container can run helper functions, example is log messages.

## Init Container

- If any init cont fails, whole Pod is restarted
- make init conts idempotent

## Details

- [Sidecar](/stgd/004-multi-container-pod/sidecar-pattern.md)
- [Adapter](/stgd/004-multi-container-pod/adapter-pattern.md)
- [Ambassador](/stgd/004-multi-container-pod/ambassador-pattern.md)

# Observability

Following concepts are covered -

- Readiness probe
- Liveness probe
- Startup probe
- Troubleshooting Kubernetes objects
- Monitoring

## Table of Content  <!-- omit in toc -->

- [Observability](#observability)
  - [Readiness probe](#readiness-probe)
  - [Liveness probe](#liveness-probe)
  - [Startup probe](#startup-probe)
  - [Probe commands](#probe-commands)
    - [Fine-tuning attribute](#fine-tuning-attribute)
  - [Teardown](#teardown)


## Readiness probe

Checks if application is ready to serve.

## Liveness probe

Periodically checks application for liveness.

## Startup probe

Waits pre-defined period time before liveness probe to start-up.

## Probe commands

| method | option | description |
|---     |---     |---          |
|custom  |exec.commnad| execute a command inside the container and check exit command|
|http get| httpGet| send an HTTP get to exposed api of application|
|tcp socket| tcpSocket| tries to open a TCP socket to a port|

### Fine-tuning attribute

|attribute |default  |description                   |
|---       |---      |---                           |
|initialDelaySeconds |0  | delay before first check |
|periodSeconds       |10 | interval between checks  |
|timeoutSeconds      |1  | check operation time out |
|successThreshold    |1  | number of checks         |
|failureThreshold    |3  | failure checks (retry)   |

## Teardown

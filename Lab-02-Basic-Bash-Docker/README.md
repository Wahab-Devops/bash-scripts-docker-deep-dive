# Lab 2 — Basic Bash and Docker

![Bash](https://img.shields.io/badge/Bash-Scripting-4EAA25?logo=gnubash&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-Nginx-2496ED?logo=docker&logoColor=white)

## Overview

This exercise uses a Bash script to pull the official Nginx image and start a container with host port `8080` mapped to container port `80`.

## Objectives

1. Pull an image from Docker Hub using `docker pull`.
2. Start a container in detached mode using `docker run -d`.
3. Publish a container port to the host.
4. Check the command result and verify that Nginx responds.

## Files

| File | Purpose |
|---|---|
| [`lab2_script.sh`](./lab2_script.sh) | Lab implementation |
| [`Lab2_Basic_Bash_Script_with_Docker.md`](./Lab2_Basic_Bash_Script_with_Docker.md) | Concepts, script walkthrough, verification, cleanup, and troubleshooting |

## Prerequisites

- Bash and Docker Engine installed.
- Docker daemon running.
- Permission to access the Docker daemon.
- Host port `8080` available.

See [Lab 1](../Lab-01-EC2-Docker-Installation/) for the Docker installation exercise.

## Run

```bash
chmod +x lab2_script.sh
./lab2_script.sh
```

## Verify

```bash
docker ps
curl http://localhost:8080
```

The container should appear in `docker ps` with host port `8080` published to container port `80`. The HTTP request should return the Nginx welcome page.

> **AWS EC2:** To access Nginx from outside the instance, configure an inbound Security Group rule for TCP port 8080 and browse to `http://<EC2-public-IP>:8080`. Restrict the source CIDR to trusted IP addresses rather than opening the port to everyone.

## Cleanup

```bash
docker stop nginx-container
docker rm nginx-container
```

## Concepts Practiced

- Bash shebangs, comments, and exit-status checks.
- Docker image retrieval and detached container execution.
- Host-to-container port mapping.
- Basic container and HTTP verification.

## Next Lab

[Lab 3 — Conditional Bash and Docker](../Lab-03-Conditional-Bash-Docker/).

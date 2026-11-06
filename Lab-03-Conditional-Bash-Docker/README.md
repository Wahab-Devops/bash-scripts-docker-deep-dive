# Lab 3 — Conditional Bash and Docker

![Bash](https://img.shields.io/badge/Bash-Scripting-4EAA25?logo=gnubash&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-Containers-2496ED?logo=docker&logoColor=white)

## Overview

This lab uses Bash conditional logic to check whether a named Docker container is running. If the container is not running, the script attempts to start the existing container.

## Objectives

1. Store a container name in a Bash variable.
2. use a Docker command to inspect running containers.
3. Use an `if / else` condition to select the next action.
4. Check the result of the start operation.

## Files

| File | Purpose |
|---|---|
| [`lab3_script.sh`](./lab3_script.sh) | Lab implementation |
| [`Lab3_Conditional_Bash_Scripts_with_Docker.md`](./Lab3_Conditional_Bash_Scripts_with_Docker.md) | Concepts, code walkthrough, test cases, and troubleshooting |

## Prerequisites

- Bash and Docker Engine installed.
- Docker daemon running.
- Permission to access the Docker daemon.

See [Lab 1](../Lab-01-EC2-Docker-Installation/) for the Docker installation exercise.

## Run the Exercise

The script expects a container named `my-container`. Create a test container and stop it before running the script:

```bash
docker run -d --name my-container nginx
docker stop my-container

chmod +x lab3_script.sh
./lab3_script.sh
```

Expected behavior: the script detects that the container is not running and attempts to start it. Run the script again to exercise the already-running path.

## Cleanup

```bash
docker rm -f my-container
```

## Concepts Practiced

- Bash `if / else / fi`.
- Variables and command exit statuses.
- Filtering running containers with Docker.
- Difference between creating a container with `docker run` and starting an existing one with `docker start`.

## Important Behavior

The current script checks running containers. A container that does not appear in `docker ps` may be stopped or may not exist; the script's `docker start` command distinguishes these situations through its result. The detailed guide documents both paths.

## Next Lab

[Lab 4 — Docker Image Management](../Lab-04-Docker-Image-Management/).

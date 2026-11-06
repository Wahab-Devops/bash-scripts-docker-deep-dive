# Lab 3: Conditional Bash Scripts with Docker

**Author:** Abdul-Wahab

In this lab I write a Bash script that makes a decision: it checks whether a Docker container is running, and if it is not, the script starts it. This uses an `if / else` condition together with Docker commands.

**Environment:** Ubuntu EC2 instance with Docker installed (see [Lab 1](../Lab-01-EC2-Docker-Installation/Lab1_Overview_of_EC2.md))

---

## Table of Contents

1. [Objective](#objective)
2. [Concepts](#concepts)
3. [The Script](#the-script)
4. [How the Script Works](#how-the-script-works)
5. [How to Run It](#how-to-run-it)
6. [Test All Cases](#test-all-cases)
7. [Cleanup](#cleanup)
8. [Troubleshooting](#troubleshooting)
9. [What I Learned](#what-i-learned)

---

## Objective

Use conditional logic in Bash to manage a Docker container.

**Tasks**

1. Write a script that checks if a Docker container is running.
2. If it is not running, the script should start it.

## Concepts

| Term | Meaning |
|------|---------|
| `if / else / fi` | Bash conditional: run one block if the test succeeds, another if it fails. |
| `docker ps` | Lists **running** containers only. |
| `-f name=...` | Filter: show only containers whose name matches. |
| `grep -q` | Search quietly. It prints nothing and only returns success (`0`) or failure (`1`). |
| `docker start` | Starts an existing container that is stopped. |
| `$?` | Exit code of the last command. `0` means success. |

## The Script

File: [`lab3_script.sh`](lab3_script.sh)

```bash
#!/bin/bash

# Name of the Docker container
CONTAINER_NAME="my-container"

# Check if the container is already running
if docker ps -f name=$CONTAINER_NAME | grep -q $CONTAINER_NAME; then
echo "Container is already running."
else
echo "Container is not running. Starting..."
docker start $CONTAINER_NAME
if [ $? -eq 0 ]; then
echo "Container started successfully."
else
echo "Failed to start the container."
fi
fi
```

## How the Script Works

1. It stores the container name in the variable `CONTAINER_NAME`.
2. `docker ps -f name=$CONTAINER_NAME` lists running containers whose name matches. The output is piped to `grep -q`, which checks if the name appears.
3. **If found:** the container is running, so the script prints `Container is already running.`
4. **If not found:** the script prints `Container is not running. Starting...` and runs `docker start`.
5. It then checks the exit code (`$?`). `0` prints `Container started successfully.`, anything else prints `Failed to start the container.`

```
docker ps | grep  ──► found? ──► yes ──► "already running"
                          │
                          no
                          ▼
                    docker start ──► exit code 0? ──► success / failed message
```

## How to Run It

Replace `my-container` with the name of your own container, or create a test container with that name (see below).

```bash
chmod +x lab3_script.sh
./lab3_script.sh
```

## Test All Cases

**Case 1: container does not exist yet (failure path)**

```bash
./lab3_script.sh
```

Expected output:

```
Container is not running. Starting...
Error response from daemon: No such container: my-container
Error: failed to start containers: my-container
Failed to start the container.
```

**Case 2: container exists but is stopped (start path)**

```bash
docker run -d --name my-container nginx
docker stop my-container
./lab3_script.sh
```

Expected output:

```
Container is not running. Starting...
my-container
Container started successfully.
```

**Case 3: container is already running**

```bash
./lab3_script.sh
```

Expected output:

```
Container is already running.
```

## Cleanup

```bash
docker rm -f my-container
```

## Troubleshooting

| Problem | Cause | Fix |
|---------|-------|-----|
| `Failed to start the container.` with `No such container` | The container was never created | Create it first with `docker run -d --name my-container nginx` |
| `permission denied ... docker.sock` | User is not in the `docker` group | `sudo usermod -aG docker $USER`, then log out and in again |
| `Permission denied` when running `./lab3_script.sh` | Script is not executable | `chmod +x lab3_script.sh` |
| Script says "already running" for a similar name | `docker ps -f name=` matches part of a name (for example `my-container-2`) | Use a unique container name |

## What I Learned

- How to use `if / else` to make a Bash script take decisions.
- How `docker ps -f name=...` and `grep -q` can check whether a container is running.
- The difference between `docker run` (creates a new container) and `docker start` (starts an existing one).
- How to use the exit code (`$?`) to report success or failure.
- How to test every path of a script: running, stopped and missing container.

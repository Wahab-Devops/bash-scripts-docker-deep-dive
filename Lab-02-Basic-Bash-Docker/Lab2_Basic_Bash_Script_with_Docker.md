# Lab 2: Basic Bash Script with Docker

**Author:** Abdul-Wahab

In this lab I write a Bash script that talks to Docker: it pulls the official Nginx image and runs it as a container. This is my first step towards automating Docker with shell scripts.

**Environment:** Ubuntu EC2 instance with Docker installed (see [Lab 1](../Lab-01-EC2-Docker/Lab1_Overview_of_EC2.md))

---

## Table of Contents

1. [Objective](#objective)
2. [Concepts](#concepts)
3. [The Script](#the-script)
4. [How to Run It](#how-to-run-it)
5. [How the Script Works](#how-the-script-works)
6. [Verify the Result](#verify-the-result)
7. [Cleanup](#cleanup)
8. [Troubleshooting](#troubleshooting)
9. [What I Learned](#what-i-learned)

---

## Objective

Understand the basic interaction between Bash and Docker.

**Tasks**

1. Write a Bash script that pulls an Nginx Docker image.
2. Run a Docker container from that image through the script.

## Concepts

| Term | Meaning |
|------|---------|
| Shebang (`#!`) | First line of a script. It tells the system which interpreter runs the file. |
| Exit code (`$?`) | Number returned by the last command. `0` means success, anything else means failure. |
| `docker pull` | Downloads an image from Docker Hub. |
| `docker run -d` | Starts a container in detached mode (in the background). |
| `-p 8080:80` | Port mapping: host port 8080 goes to container port 80. |
| `--name` | Gives the container a fixed name so it is easy to find. |

## The Script

File: [`lab2_script.sh`](lab2_script.sh)

```bash
#!/bin/bash

# Task 1: Pull Nginx Docker image
echo "Task 1: Pulling Nginx Docker image"
docker pull nginx

# Check if image pull was successful
if [ $? -eq 0 ]; then
echo "Image pull successful: Nginx Docker image"
else
echo "Image pull failed: Nginx Docker image"
exit 1
fi

# Task 2: Run Docker container
echo "Task 2: Running Docker container"
docker run -d -p 8080:80 --name nginx-container nginx

# Check if container is running
if docker ps | grep -q nginx-container; then
echo "Nginx container is running and accessible at http://localhost:8080"
else
echo "Failed to start Nginx container."
exit 1
fi

# End of script
echo "Lab 2 tasks completed."
```

## How to Run It

```bash
chmod +x lab2_script.sh
./lab2_script.sh
```

Expected output (image IDs and layers will differ):

```
Task 1: Pulling nginx Docker image
Using default tag: latest
latest: Pulling from library/nginx
...
Status: Downloaded newer image for nginx:latest
Image pull successful: nginx Docker image
Task 2: Running Docker container
<container id>
Nginx container is running and accessible at http://localhost:8080
Lab 2 tasks completed.
```

## How the Script Works

1. **Shebang** `#!/bin/bash` marks the file as a Bash script.
2. **Comments** explain each step and its objective.
3. **Task 1:** `docker pull nginx` downloads the Nginx image.
4. **Exit code check:** `$?` holds the exit code of the last command (the pull). `-eq 0` means success, so the script prints a success message. Otherwise it prints a failure message and exits with `1`.
5. **Task 2:** `docker run -d -p 8080:80 --name nginx-container nginx` runs the container in detached mode and maps host port 8080 to container port 80.
6. **Running check:** `docker ps` lists running containers and `grep -q nginx-container` searches for the container name quietly. A message is printed based on the result.
7. **End:** the script prints that the Lab 2 tasks are completed.

## Verify the Result

```bash
docker ps
```

You should see `nginx-container` with `0.0.0.0:8080->80/tcp` in the PORTS column.

```bash
curl http://localhost:8080
```

This should return the "Welcome to nginx!" HTML page.

> **EC2 note:** to open the page in a browser from your own computer, add an inbound rule for **TCP port 8080** in the instance's Security Group, then visit `http://<EC2-public-IP>:8080`.

## Cleanup

```bash
docker stop nginx-container
docker rm nginx-container
```

## Troubleshooting

| Problem | Cause | Fix |
|---------|-------|-----|
| `permission denied ... docker.sock` | User is not in the `docker` group | `sudo usermod -aG docker $USER`, then log out and in again |
| `The container name "/nginx-container" is already in use` | Old container still exists | `docker rm -f nginx-container`, then run the script again |
| `port is already allocated` | Something else uses port 8080 | Change `HOST_PORT` in the script |
| `Permission denied` when running `./lab2_script.sh` | Script is not executable | `chmod +x lab2_script.sh` |
| Page does not open in the browser on EC2 | Security Group blocks port 8080 | Add an inbound rule for TCP 8080 |

## What I Learned

- How to pull an image and start a container from a Bash script.
- How to use exit codes (`$?`) and `if` statements to check whether a command worked.
- What port mapping does (`host:container`).
- Why clear success and failure messages (with `exit 1` on failure) make scripts easier to trust.
- How to verify a container with `docker ps` and `curl`.

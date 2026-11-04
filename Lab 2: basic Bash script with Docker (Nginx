# 🐳 Lab 2: Basic Bash Script with Docker

![Bash](https://img.shields.io/badge/Bash-Script-4EAA25?logo=gnubash&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-Nginx-2496ED?logo=docker&logoColor=white)
![Level](https://img.shields.io/badge/Level-Beginner-blue)

A Bash script that **pulls the official Nginx image** and **runs it as a container** on port 8080. This lab shows the basic way Bash and Docker work together.

> **Author:** Abdul-Wahab · **Previous:** [Lab 1: EC2 and Docker Installation](../Lab-01-EC2-Docker/)

---

## 🎯 Objective

| # | Task |
|---|------|
| 1 | Write a Bash script that pulls an Nginx Docker image |
| 2 | Run a Docker container from that image using the script |

## 📁 Files

| File | Description |
|------|-------------|
| [`Lab2_Basic_Bash_Script_with_Docker.md`](Lab2_Basic_Bash_Script_with_Docker.md) | Full write-up: concepts, script explanation, verification, troubleshooting |
| [`lab2_script.sh`](lab2_script.sh) | The Bash script |

## 🚀 Quick Start

**Requirement:** Docker installed (see Lab 1).

```bash
chmod +x lab2_script.sh
./lab2_script.sh
```

Then check that Nginx is serving the page:

```bash
docker ps
curl http://localhost:8080
```

## ✅ Expected Output

```
Task 1: Pulling Nginx Docker image
...
Image pull successful: Nginx Docker image
Task 2: Running Docker container
<container id>
Nginx container is running and accessible at http://localhost:8080
Lab 2 tasks completed.
```

## 🧹 Cleanup

```bash
docker stop nginx-container
docker rm nginx-container
```

## 📚 What This Lab Covers

- Shebang and comments in a Bash script
- Checking a command's exit code with `$?`
- `docker pull`, `docker run -d` and port mapping (`-p 8080:80`)
- Checking a running container with `docker ps | grep`


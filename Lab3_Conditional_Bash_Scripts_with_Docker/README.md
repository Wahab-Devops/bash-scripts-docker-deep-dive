# 🔀 Lab 3: Conditional Bash Scripts with Docker

![Bash](https://img.shields.io/badge/Bash-Script-4EAA25?logo=gnubash&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-Containers-2496ED?logo=docker&logoColor=white)
![Level](https://img.shields.io/badge/Level-Beginner-blue)

A Bash script that **checks if a Docker container is running** and **starts it if it is not**. This lab introduces `if / else` logic with Docker.

> **Author:** Abdul-Wahab · **Previous:** [Lab 2: Basic Bash Script with Docker](../Lab-02-Basic-Bash-Docker/)

---

## 🎯 Objective

| # | Task |
|---|------|
| 1 | Write a script that checks if a Docker container is running |
| 2 | If it is not running, start it |

## 📁 Files

| File | Description |
|------|-------------|
| [`Lab3_Conditional_Bash_Scripts_with_Docker.md`](Lab3_Conditional_Bash_Scripts_with_Docker.md) | Full write-up: concepts, script explanation, test cases, troubleshooting |
| [`lab3_script.sh`](lab3_script.sh) | The Bash script |

## 🚀 Quick Start

**Requirement:** Docker installed (see Lab 1).

Create a stopped test container, then run the script:

```bash
docker run -d --name my-container nginx
docker stop my-container

chmod +x lab3_script.sh
./lab3_script.sh
```

## ✅ Expected Output

```
Container is not running. Starting...
my-container
Container started successfully.
```

Run it again and the script reports:

```
Container is already running.
```

## 🧹 Cleanup

```bash
docker rm -f my-container
```

## 📚 What This Lab Covers

- `if / else / fi` conditions in Bash
- Checking containers with `docker ps -f name=...` and `grep -q`
- Starting a container with `docker start`
- Checking success with the exit code `$?`


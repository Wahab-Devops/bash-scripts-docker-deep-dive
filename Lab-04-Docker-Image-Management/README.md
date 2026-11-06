# 🧹 Lab 4: Docker Image Management with Bash Loops

![Bash](https://img.shields.io/badge/Bash-Script-4EAA25?logo=gnubash&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-Images-2496ED?logo=docker&logoColor=white)
![Level](https://img.shields.io/badge/Level-Beginner-blue)

A Bash script that **lists all Docker images** and uses a **loop** to ask, image by image, whether to remove it.

> **Author:** Abdul-Wahab · **Previous:** [Lab 3: Conditional Bash Scripts with Docker](../Lab-03-Conditional-Bash-Docker/)

---

## 🎯 Objective

| # | Task |
|---|------|
| 1 | Write a script that lists all Docker images |
| 2 | Use a loop to remove each image interactively |

## 📁 Files

| File | Description |
|------|-------------|
| [`Lab4_Docker_Image_Management.md`](Lab4_Docker_Image_Management.md) | Full write-up: concepts, script explanation, example session, troubleshooting |
| [`docker_image_management.sh`](docker_image_management.sh) | The Bash script |

## 🚀 Quick Start

**Requirement:** Docker installed (see Lab 1).

```bash
chmod +x docker_image_management.sh
./docker_image_management.sh
```

For each image, type `yes` to remove it or anything else to skip it.

## ⚠️ Warning

`docker rmi` permanently removes images from the machine. Practice with small test images (`docker pull hello-world`, `docker pull alpine`) and be careful on production systems.

## 📚 What This Lab Covers

- `while read` loop over `docker images --format` output
- Asking for user confirmation with `read -p` and `</dev/tty`
- Removing images with `docker rmi`
- Image management through Bash


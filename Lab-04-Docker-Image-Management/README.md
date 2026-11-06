# Lab 4 — Docker Image Management with Bash Loops

![Bash](https://img.shields.io/badge/Bash-Scripting-4EAA25?logo=gnubash&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-Images-2496ED?logo=docker&logoColor=white)

## Overview

This lab uses a Bash loop to list local Docker images and prompt for a decision for each image. The script removes an image only when the response is exactly `yes`; other responses skip that image.

## Objectives

1. List local Docker images.
2. Format image information for line-by-line processing.
3. Iterate over the image list with `while read`.
4. Request interactive confirmation before image removal.

## Files

| File | Purpose |
|---|---|
| [`docker_image_management.sh`](./docker_image_management.sh) | Lab implementation |
| [`Lab4_Docker_Image_Management.md`](./Lab4_Docker_Image_Management.md) | Concepts, script walkthrough, example session, safety notes, and troubleshooting |

## Prerequisites

- Bash and Docker Engine installed.
- Docker daemon running.
- An interactive terminal, because the script prompts for confirmation.
- Permission to access the Docker daemon.

See [Lab 1](../Lab-01-EC2-Docker-Installation/) for the Docker installation exercise.

## Run

For a controlled practice exercise, first pull disposable images:

```bash
docker pull hello-world
docker pull alpine
```

Then run the script:

```bash
chmod +x docker_image_management.sh
./docker_image_management.sh
```

Review each image name and ID. Enter `yes` only when you intend to remove that image.

## Safety

This script removes local Docker images. An image may be needed by other containers or projects, and removing it can require downloading it again. Do not use this exercise on production hosts or remove images you cannot recreate.

## Concepts Practiced

- Docker image listing and formatted command output.
- Bash `while read` loops.
- Interactive input using `read` and `/dev/tty`.
- Image removal with `docker rmi`.
- Explicit confirmation before a destructive action.

## Detailed Guide

See [Lab 4 — Docker Image Management](./Lab4_Docker_Image_Management.md).

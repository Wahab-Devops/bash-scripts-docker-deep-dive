# Lab 1 — Amazon EC2 and Docker Installation

## Overview

This lab introduces the core concepts of Amazon EC2 and documents the installation and verification of Docker Engine on an Ubuntu EC2 instance.

## Objectives

- Understand the purpose of EC2 instances and related AWS concepts.
- Configure an Ubuntu environment for Docker Engine.
- Install Docker using Docker's official Ubuntu package repository.
- Verify the Docker service and run a test container.
- Understand how Docker permissions work.

## Topics Covered

- EC2 instances, AMIs, instance types, Regions, Availability Zones, and Security Groups.
- Ubuntu package management and repository signing keys.
- Docker Engine, CLI, containerd, Buildx, and the Compose plugin.
- Service verification and basic troubleshooting.

## Repository Files

| File | Purpose |
|---|---|
| [`install_docker.sh`](./install_docker.sh) | Docker installation script |
| [`Lab1_Overview_of_EC2.md`](./Lab1_Overview_of_EC2.md) | Detailed concepts, installation procedure, verification, and troubleshooting |

## Before You Start

- An AWS account and an Ubuntu EC2 instance.
- SSH access to the instance.
- A user with permission to run administrative commands using `sudo`.
- An internet connection to retrieve Ubuntu and Docker packages.

## Run and Verify

Review the installation script before executing it. Then, if it matches your environment:

```bash
chmod +x install_docker.sh
./install_docker.sh
```

Verify Docker using the commands in the detailed walkthrough:

```bash
sudo systemctl status docker
docker --version
sudo docker run hello-world
```

## Expected Outcome

Docker Engine is installed and the Docker service can run a test container. Exact package versions and command output depend on the Ubuntu release and repository state.

## Related Documentation

Continue to [Lab 2 — Basic Bash and Docker](../Lab-02-Basic-Bash-Docker/).

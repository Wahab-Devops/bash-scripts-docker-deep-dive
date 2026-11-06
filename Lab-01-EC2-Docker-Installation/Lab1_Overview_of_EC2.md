# Lab 1: Overview of EC2 and Docker Installation

**Author:** Abdul-Wahab

In this lab I learn the basics of Amazon EC2 and then install Docker Engine on an Ubuntu EC2 instance using Docker's official repository.

**Tested on:** Ubuntu 26.04 LTS (`resolute`) on an AWS EC2 instance

---

## Table of Contents

1. [Overview of EC2](#overview-of-ec2)
2. [Docker Installation on EC2](#docker-installation-on-ec2)
3. [Verify the Installation](#verify-the-installation)
4. [Run Docker Without sudo](#run-docker-without-sudo)
5. [Troubleshooting](#troubleshooting)
6. [What I Learned](#what-i-learned)

---

## Overview of EC2

Amazon Elastic Compute Cloud (Amazon EC2) is a web service from Amazon Web Services (AWS) that lets you rent virtual servers, called **instances**, in the cloud. You can scale them up or down as needed and pay only for what you use.

### Key Concepts

| Concept | Description |
| --- | --- |
| **Instances** | Virtual servers rented on demand. Different instance types are optimized for different workloads (general purpose, compute optimized, memory optimized, and so on). |
| **AMI (Amazon Machine Image)** | A pre-configured image that contains the operating system and any extra software. You can use an existing AMI or create your own. |
| **Instance Types** | Each type has a different amount of CPU, memory, storage and network capacity. |
| **Regions and Availability Zones** | AWS data centers are grouped into regions, and each region is split into Availability Zones (AZs) with separate power, cooling and networking. Spreading instances across AZs improves availability and fault tolerance. |
| **Security Groups** | Virtual firewall rules that control inbound and outbound traffic to an instance. |
| **Elastic IP** | A static public IP address that stays the same even when the instance is stopped and started. |
| **EBS (Elastic Block Store)** | Block storage volumes that attach to EC2 instances, with different volume types for different use cases. |

### Benefits and Use Cases

- **Scalability:** scale capacity up or down based on demand.
- **Flexibility:** choose the instance type and configuration that fits the application.
- **Cost control:** pricing options include On-Demand, Reserved and Spot instances.
- **Diverse workloads:** web hosting, data processing, machine learning, high-performance computing.
- **Testing and development:** quick environments for testing software and building applications.
- **High availability:** distribute instances across AZs for fault tolerance.

### Getting Started with EC2

- **Launch an instance:** select an AMI, choose an instance type, configure the network settings and launch.
- **Management:** use the AWS Management Console, the AWS CLI or the SDKs.
- **Auto Scaling:** automatically adjust the number of instances based on demand.
- **Load balancing:** Elastic Load Balancing (ELB) spreads incoming traffic across multiple instances.
- **Monitoring and logging:** Amazon CloudWatch gives metrics, resource utilization and logs.

EC2 is a cornerstone of cloud computing. It lets you deploy and manage virtual servers without a big upfront hardware investment.

---

## Docker Installation on EC2

> **Note:** Older guides use `apt-key add` and a `bionic` (Ubuntu 18.04) repository. Both are outdated. `apt-key` has been removed from current Ubuntu, and the repository must match your own Ubuntu release. The steps below use the current method from Docker's official documentation.

### Step 0: Remove the old repo (only if you tried the old method)

If you earlier ran `add-apt-repository` with `bionic`, delete the file it created:

```bash
sudo rm -f /etc/apt/sources.list.d/archive_uri-https_download_docker_com_linux_ubuntu-resolute.list
```

### Step 1: Update the package index

```bash
sudo apt update
```

### Step 2: Install the prerequisites

```bash
sudo apt install -y ca-certificates curl
```

`apt-transport-https` and `software-properties-common` are no longer needed for this method.

### Step 3: Add Docker's official GPG key

```bash
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
```

This saves the key in `/etc/apt/keyrings/` so apt can verify that Docker's packages are genuine.

### Step 4: Add the Docker repository

```bash
sudo tee /etc/apt/sources.list.d/docker.sources <<EOF
Types: deb
URIs: https://download.docker.com/linux/ubuntu
Suites: $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}")
Components: stable
Architectures: $(dpkg --print-architecture)
Signed-By: /etc/apt/keyrings/docker.asc
EOF
```

`Suites` is filled in automatically with the codename of my Ubuntu release, and `Signed-By` ties the key to this repository only.

### Step 5: Update again and check the package source

```bash
sudo apt update
apt-cache policy docker-ce
```

`apt-cache policy` should now show a **Candidate** version coming from `download.docker.com`.

### Step 6: Install Docker Engine

```bash
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

| Package | Purpose |
| --- | --- |
| `docker-ce` | Docker Engine (the daemon) |
| `docker-ce-cli` | The `docker` command |
| `containerd.io` | Container runtime |
| `docker-buildx-plugin` | Extended image builds |
| `docker-compose-plugin` | Multi-container apps with `docker compose` |

---

## Verify the Installation

Check that the service is running:

```bash
sudo systemctl status docker
```

Expected output (the details will differ on your machine):

```text
● docker.service - Docker Application Container Engine
     Loaded: loaded (/usr/lib/systemd/system/docker.service; enabled; ...)
     Active: active (running) since ...
```

Press `q` to leave the status view. Then check the version and run a test container:

```bash
docker --version
sudo docker run hello-world
```

If `hello-world` prints a "Hello from Docker!" message, Docker is working.

---

## Run Docker Without sudo

By default only `root` and members of the `docker` group can use Docker. Add the current user to the group:

```bash
sudo usermod -aG docker $USER
newgrp docker
```

Log out and log back in if the change does not apply. Then test:

```bash
docker run hello-world
```

---

## Troubleshooting

These are the errors I hit during this lab and how I fixed them.

| Error | Cause | Fix |
| --- | --- | --- |
| `sudo: 'apt-key': command not found` | `apt-key` is removed on new Ubuntu | Use the keyring method in Step 3 |
| `NO_PUBKEY 7EA0A9C3F273FCD8` | The Docker key was never imported properly | Download the key to `/etc/apt/keyrings/docker.asc` and use `Signed-By` |
| `The repository '.../ubuntu bionic InRelease' is not signed` | I added the old `bionic` repo | Delete the old `.list` file (Step 0) and add the correct repo (Step 4) |
| `Package docker-ce is not available` and `Candidate: (none)` | The repo was not added or was not trusted | Fix the repo and key, then run `sudo apt update` |
| `Unit docker.service could not be found` | Docker was never installed | Complete Step 6 |
| `curl: Failed writing body` | `curl` output was piped into a command that failed | Save the key with `-o` instead of piping |
| `404` from `apt update` for the repo | Docker has not published packages for this Ubuntu release yet | Edit `/etc/apt/sources.list.d/docker.sources`, change `Suites:` to `noble`, then run `sudo apt update` |

### Shortcut (for lab use only)

Docker also provides a convenience script that picks the right repository and installs everything:

```bash
curl -fsSL https://get.docker.com | sudo sh
```

I use the manual steps above to understand what happens, and the script only for quick test machines.

---

## What I Learned

- What EC2 is and the main parts of it: instances, AMIs, security groups, Elastic IPs and EBS.
- Why guides go out of date, and why I must match the repository to my own Ubuntu release.
- How apt verifies packages with GPG keys, and why `Signed-By` is safer than the old `apt-key`.
- How to install Docker Engine, verify it and run it without `sudo`.
- How to read apt errors such as `NO_PUBKEY` and fix the cause.

## References

- [Docker Docs: Install Docker Engine on Ubuntu](https://docs.docker.com/engine/install/ubuntu/)
- [AWS Docs: Amazon EC2](https://docs.aws.amazon.com/ec2/)

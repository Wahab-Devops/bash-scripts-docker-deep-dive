# Bash Scripting & Docker Automation Labs

A practical repository of Bash, Linux, Docker, and AWS EC2 exercises. Each lab documents its objective, implementation, execution steps, verification, troubleshooting, and key takeaways.

> **Scope:** This repository documents Labs 1–4. The Bash scripts are the original lab implementations; the documentation describes how to use and verify them.

## Technology Stack

| Technology | Role in this repository |
|---|---|
| Bash | Variables, conditionals, loops, command exit statuses, and automation |
| Ubuntu / Linux | Command-line environment and package management |
| Docker | Images, containers, port mapping, and image cleanup |
| AWS EC2 | Cloud virtual machine used for the installation exercise |
| Git & GitHub | Version control and project documentation |

## Lab Index

| Lab | Focus | Practical work | Documentation |
|---|---|---|---|
| [Lab 1 — EC2 & Docker Installation](./Lab-01-EC2-Docker-Installation/) | Cloud and container runtime setup | Explore EC2 and install/verify Docker Engine on Ubuntu | [Detailed walkthrough](./Lab-01-EC2-Docker-Installation/Lab1_Overview_of_EC2.md) |
| [Lab 2 — Basic Bash & Docker](./Lab-02-Basic-Bash-Docker/) | Run a container from Bash | Pull Nginx, run a container, map host port 8080 to container port 80 | [Detailed walkthrough](./Lab-02-Basic-Bash-Docker/Lab2_Basic_Bash_Script_with_Docker.md) |
| [Lab 3 — Conditional Bash & Docker](./Lab-03-Conditional-Bash-Docker/) | Conditional container handling | Check whether a named container is running and start it when stopped | [Detailed walkthrough](./Lab-03-Conditional-Bash-Docker/Lab3_Conditional_Bash_Scripts_with_Docker.md) |
| [Lab 4 — Docker Image Management](./Lab-04-Docker-Image-Management/) | Loop-based image management | List local images and request confirmation before removal | [Detailed walkthrough](./Lab-04-Docker-Image-Management/Lab4_Docker_Image_Management.md) |

## Repository Layout

```text
bash-scripts-docker-deep-dive/
├── Lab-01-EC2-Docker-Installation/
│   ├── install_docker.sh
│   ├── Lab1_Overview_of_EC2.md
│   └── README.md
├── Lab-02-Basic-Bash-Docker/
│   ├── lab2_script.sh
│   ├── Lab2_Basic_Bash_Script_with_Docker.md
│   └── README.md
├── Lab-03-Conditional-Bash-Docker/
│   ├── lab3_script.sh
│   ├── Lab3_Conditional_Bash_Scripts_with_Docker.md
│   └── README.md
├── Lab-04-Docker-Image-Management/
│   ├── docker_image_management.sh
│   ├── Lab4_Docker_Image_Management.md
│   └── README.md
└── README.md
```

## Prerequisites

- An Ubuntu environment, such as a local virtual machine or AWS EC2 instance.
- Bash.
- Docker Engine for Labs 2–4.
- Git, if you want to clone the repository.

See the [Lab 1 installation guide](./Lab-01-EC2-Docker-Installation/Lab1_Overview_of_EC2.md) before running Docker-based exercises.

## Getting Started

```bash
git clone https://github.com/Wahab-Devops/bash-scripts-docker-deep-dive.git
cd bash-scripts-docker-deep-dive
```

Open the required lab directory and follow its README. For example, Lab 2:

```bash
cd Lab-02-Basic-Bash-Docker
chmod +x lab2_script.sh
./lab2_script.sh
```

Each lab's detailed document explains prerequisites, commands, expected behavior, verification, and cleanup. Review a script before executing it, and run it only in an environment you control.

## Engineering Topics Practiced

- Bash scripting and command exit-status checks.
- Conditional logic and iteration over command output.
- Docker image and container operations.
- Port publishing and service verification.
- Linux package installation and service management.
- Troubleshooting and technical documentation.

## Safety and Operational Notes

- Docker commands can change or remove local resources. Understand each command before running it.
- Lab 4 can remove local Docker images. Check the image name and ID carefully before confirming removal.
- Access to the Docker daemon is highly privileged. Membership in the `docker` group effectively grants root-level capabilities.
- Do not run learning scripts against production hosts or images you cannot recreate.

## Current Scope

The repository currently contains four documented labs. Future exercises may cover stronger input validation, ShellCheck, CI workflows, and more complete containerized application deployments. These are future enhancements, not claims about completed work.

## References

- [Docker Engine documentation](https://docs.docker.com/engine/)
- [Install Docker Engine on Ubuntu](https://docs.docker.com/engine/install/ubuntu/)
- [Amazon EC2 documentation](https://docs.aws.amazon.com/ec2/)
- [GNU Bash Reference Manual](https://www.gnu.org/software/bash/manual/)

---
Feedback and technical suggestions are welcome.

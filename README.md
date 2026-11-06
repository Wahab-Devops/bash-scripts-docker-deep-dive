# Bash Scripting & Docker Automation Labs

A hands-on repository documenting practical work with **Bash scripting, Linux, Docker, and AWS EC2**. Each lab focuses on a specific task, with scripts and supporting notes explaining the objective, execution steps, verification, and lessons learned.

## Repository Overview

This repository brings together practical exercises in Linux-based automation and Docker container management. The goal is to build repeatable command-line workflows, understand how Bash can automate infrastructure tasks, and document the process clearly.

## Technology Stack

- **Bash** — shell scripting, variables, conditions, loops, and command exit statuses
- **Linux / Ubuntu** — command-line environment and package management
- **Docker** — images, containers, container execution, and image cleanup
- **AWS EC2** — cloud virtual machine environment used in the installation lab
- **Git & GitHub** — version control and project documentation

## Labs

| Lab | Focus | What it covers |
| --- | --- | --- |
| [Lab 1 — EC2 & Docker Installation](./Lab-01-EC2-Docker-Installation/) | Cloud environment and installation | EC2 fundamentals, Docker Engine installation on Ubuntu, installation verification, and troubleshooting |
| [Lab 2 — Basic Bash & Docker](./Lab-02-Basic-Bash-Docker/) | Run a container with a script | Pull the Nginx image, run a container, map port `8080:80`, and verify the service |
| [Lab 3 — Conditional Bash & Docker](./Lab-03-Conditional-Bash-Docker/) | Conditional container handling | Check whether a named container is running and start it when it is stopped |
| [Lab 4 — Docker Image Management](./Lab-04-Docker-Image-Management/) | Loop-based image management | List local Docker images, iterate through them, request confirmation, and remove selected images |

## Repository Structure

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

- An Ubuntu Linux environment (a local VM or an AWS EC2 instance)
- Bash
- Docker Engine
- Git

Some labs require Docker to be installed and running. See [Lab 1](./Lab-01-EC2-Docker-Installation/) for the installation walkthrough.

## Run a Lab

Clone the repository:

```bash
git clone https://github.com/Wahab-Devops/bash-scripts-docker-deep-dive.git
cd bash-scripts-docker-deep-dive
```

Open the lab directory you want to run, make its script executable, and execute it. For example:

```bash
cd Lab-02-Basic-Bash-Docker
chmod +x lab2_script.sh
./lab2_script.sh
```

Follow the individual lab README for its exact prerequisites, commands, expected results, and cleanup steps. Run scripts only in an environment you control and understand.

## Skills Practiced

- Writing and executing Bash scripts
- Using conditional statements and loops
- Checking command results and handling basic failures
- Automating Docker image and container tasks
- Installing and verifying Docker on Ubuntu
- Documenting procedures and troubleshooting steps

## Safety Notes

- Review a script before running it, especially when it uses `sudo` or changes Docker resources.
- Lab 4 can remove local Docker images. Confirm each image carefully before approving removal.
- Membership in the `docker` group grants root-level privileges. Use it only when you understand the security implications.
- Practice in a test environment rather than on production systems.

## Current Scope & Next Improvements

The repository currently documents Labs 1–4. Further work can extend the exercises with stronger input validation and error handling, automated shell linting with ShellCheck, and CI checks using GitHub Actions.

## References

- [Docker Engine documentation](https://docs.docker.com/engine/)
- [Docker installation on Ubuntu](https://docs.docker.com/engine/install/ubuntu/)
- [Amazon EC2 documentation](https://docs.aws.amazon.com/ec2/)
- [GNU Bash manual](https://www.gnu.org/software/bash/manual/)

---

This repository is maintained as a practical record of hands-on learning and implementation. Feedback and suggestions for improving the scripts and documentation are welcome.

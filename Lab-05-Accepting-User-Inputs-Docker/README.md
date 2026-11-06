# Lab 5: Accepting User Inputs for Docker Operations

## Objective
Enhance user input handling in Bash for Docker-related tasks.

## Tasks
1. Write a script that accepts an image name as input.
2. The script then pulls and runs the Docker image.

## Prerequisites
- AWS account with administrative access
- Docker Deep Dive Course
- Bash Script Deep Dive Course
- Completion of previous labs

## Technologies
- Linux
- Bash Scripting
- Docker
- AWS EC2
- Git & GitHub

## Implementation

This lab demonstrates how to accept user input in a Bash script and dynamically manage Docker images and containers.

The script asks the user to enter a Docker image name, pulls the specified image, and runs a container based on that image.

## Files
- `docker_operations.sh` — Bash script for Docker operations.

## How to Run

Make the script executable:

```bash
chmod +x docker_operations.sh
```

Execute the script:

```bash
./docker_operations.sh
```

Enter the Docker image name when prompted.

## Key Concepts Learned
- Handling user input using the Bash `read` command.
- Using variables in Bash.
- Pulling Docker images using `docker pull`.
- Running containers using `docker run`.
- Using interactive Docker containers with `-it`.
- Automatically removing containers using `--rm`.

## Expected Outcome

The script accepts a Docker image name from the user, pulls the image, and runs a container based on the provided image.


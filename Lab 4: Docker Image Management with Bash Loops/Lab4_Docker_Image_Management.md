# Lab 4: Docker Image Management with Bash Loops

**Author:** Abdul-Wahab

In this lab I write a Bash script that lists all Docker images and then uses a loop to ask, for every image, whether it should be removed. Nothing is deleted unless I type `yes`.

**Environment:** Ubuntu EC2 instance with Docker installed (see [Lab 1](../Lab-01-EC2-Docker/Lab1_Overview_of_EC2.md))

---

## Table of Contents

1. [Objective](#objective)
2. [Prerequisites](#prerequisites)
3. [Concepts](#concepts)
4. [The Script](#the-script)
5. [How to Run It](#how-to-run-it)
6. [How the Script Works](#how-the-script-works)
7. [Example Session](#example-session)
8. [Safety Note](#safety-note)
9. [Troubleshooting](#troubleshooting)
10. [What I Learned](#what-i-learned)

---

## Objective

**Tasks**

1. Write a script that lists all Docker images.
2. Use a loop to remove each image interactively.

**Documentation topics:** Bash loop structures, and Docker image management through Bash.

## Prerequisites

1. An AWS account with administrative access.
2. Docker Deep Dive course.
3. Bash Script Deep Dive course.
4. Docker installed on the EC2 instance (Lab 1).

## Concepts

| Term | Meaning |
|------|---------|
| `docker images` | Lists the images stored on the machine. |
| `--format "{{.ID}} {{.Repository}}:{{.Tag}}"` | Prints each image on one line as `ID name:tag`, which is easy to loop over. |
| `while read -r a b` | Reads the input line by line and splits each line into variables. |
| `read -p` | Shows a prompt and stores what the user types. |
| `</dev/tty` | Reads the answer from the keyboard, not from the pipe that feeds the loop. |
| `docker rmi <id>` | Removes an image by its ID. |

## The Script

File: [`docker_image_management.sh`](docker_image_management.sh)

```bash
#!/bin/bash

#!/bin/bash

# Task 1: List all Docker images
echo "Listing all Docker images:"
docker images

# Task 2: Har image ke liye alag permission lo
docker images --format "{{.ID}} {{.Repository}}:{{.Tag}}" | while read -r image_id image_name; do
echo ""
echo "Image: $image_name (ID: $image_id)"
read -p "Kya yeh image remove karni hai? (yes/no): " confirmation </dev/tty
if [ "$confirmation" == "yes" ]; then
echo "Removing $image_name ..."
docker rmi "$image_id"
else
echo "Skipped $image_name"
fi
done
echo ""
echo "Done."
```

> The prompt "Kya yeh image remove karni hai?" is Roman Urdu for "Do you want to remove this image?". The second `#!/bin/bash` line is only a comment and does not affect the script.

## How to Run It

```bash
chmod +x docker_image_management.sh
./docker_image_management.sh
```

## How the Script Works

1. **Task 1:** `docker images` prints the full list of images in a table.
2. **Task 2:** `docker images --format ...` prints one line per image (`ID name:tag`). The output is piped into a `while read` loop, so the loop runs once for every image.
3. In each round, the script shows the image name and ID, then asks `yes/no`.
4. `read ... </dev/tty` takes the answer from the keyboard. This is needed because the loop's normal input is already used by the piped image list.
5. If the answer is exactly `yes`, `docker rmi "$image_id"` removes the image. Any other answer prints `Skipped <image>`.
6. After the loop, the script prints `Done.`

Each image is asked about **separately**, so I can keep some images and remove others.

## Example Session

Safe way to practice: pull two small images first.

```bash
docker pull hello-world
docker pull alpine
./docker_image_management.sh
```

Example output (IDs and sizes will differ):

```
Listing all Docker images:
REPOSITORY    TAG       IMAGE ID       CREATED        SIZE
alpine        latest    xxxxxxxxxxxx   2 weeks ago    8MB
hello-world   latest    yyyyyyyyyyyy   10 months ago  20kB

Image: alpine:latest (ID: xxxxxxxxxxxx)
Kya yeh image remove karni hai? (yes/no): yes
Removing alpine:latest ...
Untagged: alpine:latest
Deleted: sha256:...

Image: hello-world:latest (ID: yyyyyyyyyyyy)
Kya yeh image remove karni hai? (yes/no): no
Skipped hello-world:latest

Done.
```

## Safety Note

`docker rmi` removes an image from the machine. Be careful on production systems or with images you still need. Always read the image name before typing `yes`, and make sure you can pull it again or have a backup.

## Troubleshooting

| Problem | Cause | Fix |
|---------|-------|-----|
| `image is being used by running container` | A container still uses the image | Stop and remove the container first: `docker rm -f <container>` |
| `image is referenced in multiple repositories` | Same image ID has more than one tag | Remove by name: `docker rmi name:tag` |
| `permission denied ... docker.sock` | User is not in the `docker` group | `sudo usermod -aG docker $USER`, then log out and in again |
| `Permission denied` when running the script | Script is not executable | `chmod +x docker_image_management.sh` |
| Loop does not wait for my answer | `</dev/tty` is missing from the `read` line | Keep `</dev/tty` on the `read` command |

## What I Learned

- How to loop over Docker output line by line with `while read`.
- How to format `docker images` output with `--format`.
- How to ask for user confirmation with `read -p` and why `</dev/tty` is needed inside a piped loop.
- How to remove images with `docker rmi` and why confirmation matters before deleting.

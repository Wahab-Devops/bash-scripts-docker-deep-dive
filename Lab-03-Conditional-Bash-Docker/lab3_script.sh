#!/usr/bin/env bash
#
# Lab 3: Inspect a container and start it when it is stopped.
#
# Usage:
#   ./lab3_script.sh
#   CONTAINER_NAME=nginx-container ./lab3_script.sh
#
set -Eeuo pipefail

CONTAINER_NAME="${CONTAINER_NAME:-my-container}"
log() { printf '[INFO] %s\n' "$*"; }
die() { printf '[ERROR] %s\n' "$*" >&2; exit 1; }

command -v docker >/dev/null 2>&1 || die "Docker CLI is not installed."
docker info >/dev/null 2>&1 || die "Docker daemon is unavailable. Start Docker and try again."

if ! docker container inspect "$CONTAINER_NAME" >/dev/null 2>&1; then
  die "Container '$CONTAINER_NAME' does not exist. Create it first, then rerun this lab."
fi

state="$(docker container inspect --format '{{.State.Status}}' "$CONTAINER_NAME")"
case "$state" in
  running)
    log "Container '$CONTAINER_NAME' is already running."
    ;;
  created|exited)
    log "Container '$CONTAINER_NAME' is '$state'; starting it..."
    docker container start "$CONTAINER_NAME" >/dev/null
    log "Container started successfully."
    ;;
  paused)
    log "Container '$CONTAINER_NAME' is paused; unpausing it..."
    docker container unpause "$CONTAINER_NAME" >/dev/null
    ;;
  *)
    die "Container is in state '$state'. Manual investigation is required."
    ;;
esac

docker container ls --filter "name=^/${CONTAINER_NAME}$" --format 'table {{.Names}}\t{{.Status}}\t{{.Ports}}'

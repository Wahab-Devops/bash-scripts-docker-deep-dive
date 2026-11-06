#!/usr/bin/env bash
#
# Lab 2: Pull the Nginx image and run a local container.
#
# Usage:
#   ./lab2_script.sh
#   CONTAINER_NAME=nginx-lab PORT=8081 ./lab2_script.sh
#
set -Eeuo pipefail

readonly SCRIPT_NAME="${0##*/}"
CONTAINER_NAME="${CONTAINER_NAME:-nginx-container}"
HOST_PORT="${HOST_PORT:-8080}"

log() { printf '[INFO] %s\n' "$*"; }
die() { printf '[ERROR] %s\n' "$*" >&2; exit 1; }

[[ "$HOST_PORT" =~ ^[0-9]+$ ]] && (( HOST_PORT >= 1 && HOST_PORT <= 65535 )) ||
  die "HOST_PORT must be a valid TCP port (1-65535)."

command -v docker >/dev/null 2>&1 || die "Docker CLI is not installed."
docker info >/dev/null 2>&1 || die "Docker daemon is unavailable. Start Docker and try again."

if docker container inspect "$CONTAINER_NAME" >/dev/null 2>&1; then
  if [[ "$(docker container inspect -f '{{.State.Running}}' "$CONTAINER_NAME")" == "true" ]]; then
    log "Container '$CONTAINER_NAME' is already running."
  else
    log "Starting existing container '$CONTAINER_NAME'..."
    docker start "$CONTAINER_NAME" >/dev/null
  fi
else
  log "Pulling the official Nginx image..."
  docker image pull nginx:stable
  log "Creating container '$CONTAINER_NAME' on host port $HOST_PORT..."
  docker container run --detach \
    --name "$CONTAINER_NAME" \
    --publish "$HOST_PORT:80" \
    --restart unless-stopped \
    nginx:stable
fi

docker container ls --filter "name=^/${CONTAINER_NAME}$" --format 'table {{.Names}}\t{{.Status}}\t{{.Ports}}'
log "Nginx endpoint: http://localhost:$HOST_PORT"

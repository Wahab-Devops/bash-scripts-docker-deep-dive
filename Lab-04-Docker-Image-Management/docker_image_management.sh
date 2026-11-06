#!/usr/bin/env bash
#
# Lab 4: Interactively remove selected local Docker images.
#
# Usage:
#   ./docker_image_management.sh
#
set -Eeuo pipefail

log() { printf '[INFO] %s\n' "$*"; }
warn() { printf '[WARN] %s\n' "$*" >&2; }
die() { printf '[ERROR] %s\n' "$*" >&2; exit 1; }

[[ -t 0 ]] || die "Run this script in an interactive terminal; confirmation is required."
command -v docker >/dev/null 2>&1 || die "Docker CLI is not installed."
docker info >/dev/null 2>&1 || die "Docker daemon is unavailable. Start Docker and try again."

mapfile -t image_ids < <(docker image ls --quiet | sort -u)

if (( ${#image_ids[@]} == 0 )); then
  log "No local Docker images were found."
  exit 0
fi

log "Local Docker images:"
docker image ls
printf '\n'

removed=0
skipped=0
failed=0

for image_id in "${image_ids[@]}"; do
  image_label="$(docker image inspect --format '{{join .RepoTags ", "}}' "$image_id" 2>/dev/null || printf '<untagged>')"
  printf '\nImage: %s\nID: %s\n' "$image_label" "$image_id"
  read -r -p "Remove this image? [y/N]: " answer
  case "$answer" in
    y|Y|yes|YES)
      if docker image rm "$image_id"; then
        ((removed+=1))
        log "Removed $image_id"
      else
        ((failed+=1))
        warn "Could not remove $image_id. It may be used by a container."
      fi
      ;;
    *)
      ((skipped+=1))
      log "Skipped $image_id"
      ;;
  esac
done

printf '\nSummary: removed=%d skipped=%d failed=%d\n' "$removed" "$skipped" "$failed"
(( failed == 0 )) || exit 1

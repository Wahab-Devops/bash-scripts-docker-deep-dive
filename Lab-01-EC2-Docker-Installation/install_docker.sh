#!/usr/bin/env bash
#
# Lab 1: Install Docker Engine on Ubuntu EC2
# Uses Docker's official APT repository.
#
# Usage:
#   chmod +x install_docker.sh
#   ./install_docker.sh
#
set -euo pipefail

if [[ "${EUID}" -eq 0 ]]; then
    echo "Please run this script as a normal user, not with sudo."
    echo "The script will use sudo when required."
    exit 1
fi

if ! command -v sudo >/dev/null 2>&1; then
    echo "Error: sudo is required. Install/configure sudo, then run again."
    exit 1
fi

echo "==> Updating APT package index..."
sudo apt-get update

echo "==> Installing prerequisites..."
sudo apt-get install -y ca-certificates curl

echo "==> Creating APT keyrings directory..."
sudo install -m 0755 -d /etc/apt/keyrings

echo "==> Downloading Docker's official GPG key..."
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg \
    -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

echo "==> Detecting Ubuntu release and CPU architecture..."
. /etc/os-release
UBUNTU_CODENAME="${UBUNTU_CODENAME:-${VERSION_CODENAME:-}}"
ARCH="$(dpkg --print-architecture)"

if [[ -z "${UBUNTU_CODENAME}" ]]; then
    echo "Error: Could not determine the Ubuntu release codename."
    exit 1
fi

echo "Ubuntu codename: ${UBUNTU_CODENAME}"
echo "Architecture:    ${ARCH}"

echo "==> Adding Docker's official APT repository..."
sudo tee /etc/apt/sources.list.d/docker.sources >/dev/null <<EOF
Types: deb
URIs: https://download.docker.com/linux/ubuntu
Suites: ${UBUNTU_CODENAME}
Components: stable
Architectures: ${ARCH}
Signed-By: /etc/apt/keyrings/docker.asc
EOF

echo "==> Refreshing package index..."
if ! sudo apt-get update; then
    echo
    echo "Docker's repository could not be refreshed for Ubuntu '${UBUNTU_CODENAME}'."
    echo "Check Docker's official Ubuntu installation documentation for supported releases."
    echo "Do not change the repository codename blindly; use a supported Ubuntu release."
    exit 1
fi

echo "==> Installing Docker Engine and plugins..."
sudo apt-get install -y \
    docker-ce \
    docker-ce-cli \
    containerd.io \
    docker-buildx-plugin \
    docker-compose-plugin

echo "==> Enabling and starting Docker..."
sudo systemctl enable --now docker

echo "==> Docker version:"
sudo docker --version

echo "==> Running the hello-world test container..."
sudo docker run --rm hello-world

echo
echo "Docker installation and test completed successfully."
echo "Optional: to use Docker without sudo, run:"
echo "  sudo usermod -aG docker \$USER"
echo "Then log out and log back in (or start a new group session)."
echo "Security note: membership in the docker group grants root-level privileges."

#!/usr/bin/env sh
# Shared entry point for every CI/CD pipeline in this repository.
# Required env: NETBOX_API, NETBOX_TOKEN, NET_USER, NET_PASSWORD, BACKUP_REPO_URL
# Optional env: NET_ENABLE_PASSWORD
set -eu
cd "$(dirname "$0")/.."

: "${NETBOX_API:?is required}" "${NETBOX_TOKEN:?is required}" "${NET_USER:?is required}" \
  "${NET_PASSWORD:?is required}" "${BACKUP_REPO_URL:?is required}"

# Isolated venv: avoids PEP 668 "externally managed" errors on self-hosted runners.
python3 -m venv .venv
. .venv/bin/activate
pip install --quiet --upgrade -r requirements.txt
ansible-galaxy collection install --upgrade -r collections/requirements.yml
ansible-playbook backup.yml

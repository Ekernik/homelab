#!/usr/bin/bash

set -Eeuo pipefail

SOURCE="/srv/plex/config/"
BACKUP_MOUNT="/mnt/configs/plex"
DEST="/mnt/configs/plex/current/"
PLEX_WAS_RUNNING=0

echo "Starting Plex backup."

# Ensure we are backing up to the NAS and not to the local fs.
if ! mountpoint -q "$BACKUP_MOUNT"; then
    echo "ERROR: $BACKUP_MOUNT is not mounted"
    exit 1
fi

mkdir -p "$DEST"

# Exit Handler: Restart Plex service on success or error.
start_plex_service() {
    if [[ "$PLEX_WAS_RUNNING" -eq 1 ]]; then
        echo "Starting Plex."
        systemctl start plex.service
    fi
}

trap start_plex_service EXIT

if systemctl is-active --quiet plex.service; then
    PLEX_WAS_RUNNING=1

    echo "Stopping Plex for clean sync."
    systemctl stop plex.service
fi

echo "Running rsync to NAS."
rsync \
    -a \
    --numeric-ids \
    --delete \
    "$SOURCE" \
    "$DEST"

echo "Plex Backup Completed!"
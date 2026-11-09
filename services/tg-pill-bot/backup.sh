#!/usr/bin/env bash
# Daily backup of tg-pill-bot data.

set -euo pipefail

SRC="/home/ekernik/tg-pill-bot/data"
MOUNT="/mnt/backups/tg-pill-bot"
DEST="$MOUNT/data"

# trigger x-systemd.automount
ls "$MOUNT" >/dev/null 2>&1 || true

# verify it's a real mount.
if ! mountpoint -q "$MOUNT"; then
    echo "ERROR: $MOUNT is not mounted, aborting backup" >&2
    exit 1
fi

mkdir -p "$DEST"

# Snapshot database.
TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

while IFS= read -r -d '' db; do
    rel="${db#"$SRC"/}"
    mkdir -p "$TMP/$(dirname "$rel")"
    sqlite3 "$db" ".backup '$TMP/$rel'"
done < <(find "$SRC" -type f \( -name '*.db' -o -name '*.sqlite' -o -name '*.sqlite3' \) -print0)

# Non-database files, skipping live db files and their WAL/SHM/journal sidecars.
rsync -a --delete \
    --exclude='*.db' \
    --exclude='*.db-wal' \
    --exclude='*.db-shm' \
    --exclude='*.db-journal' \
    --exclude='*.sqlite' \
    --exclude='*.sqlite-wal' \
    --exclude='*.sqlite-shm' \
    --exclude='*.sqlite-journal' \
    --exclude='*.sqlite3' \
    --exclude='*.sqlite3-wal' \
    --exclude='*.sqlite3-shm' \
    --exclude='*.sqlite3-journal' \
    "$SRC/" "$DEST/"

# Copy consistent db snapshots over.
rsync -a "$TMP/" "$DEST/"

echo "Backup completed: $(date -Is)"

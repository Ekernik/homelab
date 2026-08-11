# Plex Media Server

## Table of Contents
- [Service Description](#service-description)
- [VM Requirements](#vm-requirements)
- [Packages to Install](#packages-to-install)
- [Folders to create](#folders-to-create)
- [File locations](#file-locations)
- [System configuration](#system-configuration)

## Service Description

[Plex Media Server](https://www.plex.tv/media-server-downloads/?cat=computer&plat=linux) – is a free selfhosted media server and a web client for viewing personal video and audio libraries over the LAN.

This deployment runs Plex Media Server in [Podman Quadlet](https://www.redhat.com/en/blog/quadlet-podman). 

Container image updates are checked and applied automatically. Checkout [plex.container](./plex.container) and `podman-auto-update.timer`.

Local Plex Configs are backed up to the NAS every day at 04:00. Checkout [backup-plex.service](./backup-plex.service) and [backup-plex.timer](./backup-plex.timer).

## VM Requirements
- CPU: 2 vCPU, host 
- RAM: 4 GB
- BIOS: OVMF (UEFI)
- Machine: q35
- OS: Rocky Linux v10.2 x86_64
- Disks: 
    - scsi0
    - 64 GB
    - VirtIO SCSI Single
    - Discard - enabled
    - IO Thread - enabled
    - SSD emulation - enabled

## Packages to Install
- `nfs-utils`
- `nano`
- `vim`
- `podman`
- `qemu-guest-agent`
- `rsync`

## Folders to create
- `/mnt/media` – NFS mount point
- `/mnt/configs/plex` – NFS mount point 
- `/srv/plex/config` – Local Plex config directory

## File locations
- `plex.container` –> `/etc/containers/systemd/plex.container`
- `backup-plex.sh` –> `/usr/local/sbin/backup-plex.sh`
- `backup-plex.service` –> `/etc/systemd/system/backup-plex.service`
- `backup-plex.timer` –> `/etc/systemd/system/backup-plex.timer`
- `fstab` –> `/etc/fstab`. NOTE: append to the end of the file, don't overwrite.

## System configuration
- `sudo dnf upgrade --refresh -y`
- `sudo timedatectl set-timezone America/New_York`
- `sudo chown -R 1000:1000 /srv/plex`
- `chmod 750 /usr/local/sbin/backup-plex.sh`
- `sudo systemctl daemon-reload`
- `sudo systemctl start plex.service`
- `sudo systemctl enable --now backup-plex.timer`
- `sudo systemctl enable --now qemu-guest-agent.service`
- `sudo systemctl enable --now podman-auto-update.timer`
- `sudo firewall-cmd --permanent --add-port=32400/tcp`
- `sudo firewall-cmd --reload`


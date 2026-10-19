# Installation instructions step-by-step

Install to info-01 VM

1. dnf install podman vim bash-completion nfs-utils
2. mkdir -p ~/.config/containers/systemd/
3. mkdir -p /mnt/configs/glance
4. echo "192.168.1.250 nas.local nas" > /etc/hosts
5. echo "nas:/export/global/configs/glance /mnt/configs/glance nfs rw,\_netdev,x-systemd.automount,nofail 0 0" > /etc/fstab
6. systemctl --user daemon-reload
7. systemctl --user start glance.service
8. sudo loginctl enable-linger ekernik
9. systemctl --user enable --now podman-auto-updater.timer
10. firewall-cmd --add-port=8080/tcp

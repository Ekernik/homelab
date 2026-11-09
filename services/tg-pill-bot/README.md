# Installation instructions

Install to TG-Bots-01 VM

1. `dnf install -y podman vim bash-completion nfs-utils qemu-guest-agent sqlite`
2. `mkdir -p ~/.config/containers/systemd`
3. `mkdir -p ~/.config/systemd/user`
4. `mkdir -p /mnt/backups/tg-pill-bot`
5. `mkdir -p /home/ekernik/tg-pill-bot/data`
6. `echo "192.168.1.250 nas.local nas" > /etc/hosts`
7. `echo "nas:/export/global/backups/tg-pill-bot/ /mnt/backups/tg-pill-bot/ nfs \_netdev,x-systemd.automount,nofail 0 0" > /etc/fstab`
8. `rsync -avh --progress /mnt/backups/tg-pill-bot/data/ /home/ekernik/tg-pill-bot/data/`
9. place `tg-pill-bot-backup.service` and `tg-pill-bot-backup.timer` into `~/.config/systemd/user/`
10. `install -m 755 backup.sh /home/ekernik/tg-pill-bot-backup.sh`
11. `systemctl --user daemon-reload`
12. `systemctl --user start tg-pill-bot.service`
13. `systemctl --user enable --now tg-pill-bot-backup.timer`
14. `systemctl --user start tg-pill-bot-backup.service`
15. `systemctl --user enable --now podman-auto-updater.timer`
16. `sudo loginctl enable-linger ekernik`
17. `firewall-cmd --add-port=8080/tcp --permanent`
18. `firewall-cmd --reload`

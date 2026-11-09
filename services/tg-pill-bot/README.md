# Installation instructions

Install to TG-Bots-01 VM

1. `dnf install -y podman vim bash-completion nfs-utils qemu-guest-agent sqlite rsync`
2. `mkdir -p ~/.config/containers/systemd`
3. `mkdir -p ~/.config/systemd/user`
4. `sudo mkdir -p /mnt/backups/tg-pill-bot/data`
5. `mkdir -p ~/tg-pill-bot/data`
6. `echo "192.168.1.250 nas.local nas" | sudo tee -a /etc/hosts`
7. `echo "nas:/export/global/backups/tg-pill-bot/ /mnt/backups/tg-pill-bot/ nfs _netdev,x-systemd.automount,nofail 0 0" | sudo tee -a /etc/fstab`
8. `sudo systemctl daemon-reload`
9. `sudo mount -a`
10. `rsync -avh --progress /mnt/backups/tg-pill-bot/data/ ~/tg-pill-bot/data/`
11. place `tg-pill-bot.container` and `bot.env` into `~/.config/containers/systemd/`
12. place `tg-pill-bot-backup.service` and `tg-pill-bot-backup.timer` into `~/.config/systemd/user/`
13. `install -m 755 /mnt/backups/tg-pill-bot/backup.sh ~/tg-pill-bot-backup.sh`
14. `podman login ghcr.io`
15. `systemctl --user daemon-reload`
16. `systemctl --user start tg-pill-bot.service`
17. `systemctl --user enable --now tg-pill-bot-backup.timer`
18. `systemctl --user start tg-pill-bot-backup.service`
19. `systemctl --user enable --now podman-auto-update.timer`
20. `sudo loginctl enable-linger ekernik`
21. `sudo firewall-cmd --add-port=8080/tcp --permanent`
22. `sudo firewall-cmd --reload`

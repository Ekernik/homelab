The :z and :Z volume flags can’t relabel files on NFS, so containers will get “permission denied” unless you allow container access to NFS. Run this once:
`sudo setsebool -P virt_use_nfs 1`

Configs should be mounted, then copied to user's home directory.
`~/arrstack/config/<service>/`

`mkdir -p ~/arrstack/configs`
`rsync -a /mnt/data/config/sonarr ~/arrstack/configs`

`firewall-cmd --add-port=8989/tcp`

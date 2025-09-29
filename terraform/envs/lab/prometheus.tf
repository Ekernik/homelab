module "prometheus_lxc" {
  source          = "../../modules/proxmox-lxc"
  target_node     = "proxmox2"
  vmid            = 0
  os_type         = "ubuntu"
  description     = "Prometheus. http://192.168.1.33:9090"
  tags            = "terraform;monitoring;prometheus"
  hostname        = "prometheus.home.arpa"
  ssh_pubkey      = local.ssh_public_key
  memory          = 2048
  swap            = 1024
  disk_size       = "10G"
  ipv4_address    = "192.168.1.33/24"
  ipv4_gateway    = "192.168.1.1"
  root_password   = var.lxc_root_password
}

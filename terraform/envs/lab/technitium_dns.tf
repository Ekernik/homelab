module "technitium_dns_lxc" {
  source          = "../../modules/proxmox-lxc"
  target_node     = "proxmox2"
  vmid            = 0
  os_type         = "ubuntu"
  description     = "Technitium DNS Server. http://192.168.1.30:5380"
  tags            = "terraform;dns"
  hostname        = "dns1.home.arpa"
  ssh_pubkey      = local.ssh_public_key
  disk_size       = "2G"
  ipv4_address    = "192.168.1.30/24"
  ipv4_gateway    = "192.168.1.1"
  root_password   = var.lxc_root_password
}

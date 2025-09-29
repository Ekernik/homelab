module "nginx_proxy_manager_plus_lxc" {
  source          = "../../modules/proxmox-lxc"
  target_node     = "proxmox2"
  vmid            = 0
  os_type         = "ubuntu"
  description     = "NGINX reverse proxy manager. http://192.168.1.32:81"
  tags            = "terraform;proxy"
  hostname        = "npmplus.home.arpa"
  ssh_pubkey      = local.ssh_public_key
  disk_size       = "3G"
  ipv4_address    = "192.168.1.32/24"
  ipv4_gateway    = "192.168.1.1"
  root_password   = var.lxc_root_password
}

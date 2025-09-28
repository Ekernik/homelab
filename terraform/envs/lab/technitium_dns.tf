locals {
  ssh_public_key      = file("~/.ssh/id_rsa.pub")
  service_ip          = "192.168.1.30"
  service_CIDR        = "${local.service_ip}/24"
  service_port        = "5380"
}

variable lxc_root_password { 
  sensitive   = true
  type        = string
}

module "technitium_dns_lxc" {
  source          = "../../modules/proxmox-lxc"
  target_node     = "proxmox2"
  vmid            = 0
  os_type         = "ubuntu"
  description     = "Technitium DNS Server. http://${local.service_ip}:${local.service_port}"
  tags            = "terraform;dns"
  hostname        = "dns1.home.arpa"
  ssh_pubkey      = local.ssh_public_key
  disk_size       = "2G"
  ipv4_address    = local.service_CIDR
  ipv4_gateway    = "192.168.1.1"
  root_password   = var.lxc_root_password
}

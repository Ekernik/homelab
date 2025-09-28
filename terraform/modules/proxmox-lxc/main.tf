terraform {
    required_version = ">=1.13.0"
    required_providers {
        proxmox = {
            source = "telmate/proxmox"
            version = "~> 2.9.14"
        }
    }
}

resource "proxmox_lxc" "lxc" {
  target_node     = var.target_node
  vmid            = var.vmid
  ostemplate      = var.os_template
  ostype          = var.os_type
  arch            = var.arch
  description     = var.description
  tags            = var.tags
  hostname        = var.hostname
  password        = var.root_password
  ssh_public_keys = var.ssh_pubkey

  start           = var.start_after_creation
  unprivileged    = var.unprivileged
  onboot          = var.start_on_boot

  cores           = var.cores
  memory          = var.memory
  swap            = var.swap

  rootfs {
    storage       = var.storage
    size          = var.disk_size
  }

  nameserver      = var.nameserver
  searchdomain    = var.searchdomain
  network {
    name          = var.vnic_name
    bridge        = var.vnic_bridge
    firewall      = var.firewall
    ip            = var.ipv4_address
    gw            = var.ipv4_gateway
  }

  features {
    nesting       = var.features_nesting
  }
}

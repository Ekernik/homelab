resource "proxmox_vm_qemu" "cloud-init" {
  for_each    = var.vm_configs
  vmid        = each.value.vm_id
  name        = each.value.name
  target_node = "proxmox1"

  clone      = "ubuntu-cloudinit"
  full_clone = false
  bios       = "ovmf"
  agent      = 1
  scsihw     = "virtio-scsi-single"

  os_type = "cloud-init"
  memory  = each.value.memory

  vm_state           = each.value.vm_state
  start_at_node_boot = each.value.start_at_node_boot

  startup_shutdown {
    order = each.value.startup_order
  }

  ipconfig0  = each.value.ipconfig
  skip_ipv6  = true
  ciuser     = each.value.ciuser
  cipassword = each.value.cipassword
  sshkeys    = var.sshkeys

  cpu {
    type    = "x86-64-v2-AES"
    sockets = 1
    cores   = each.value.cores
  }

  serial {
    id   = 0
    type = "socket"
  }

  network {
    id       = 0
    model    = "virtio"
    bridge   = each.value.bridge
    firewall = true
    tag      = each.value.network_tag
  }

  disks {
    scsi {
      scsi0 {
        cloudinit {
          storage = "local-lvm"
        }
      }
      scsi1 {
        disk {
          size = "3584M"
          storage = "local-lvm"
        }
      }
    }
  }
}
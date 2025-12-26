variable "proxmox_api_url" { type = string }
variable "proxmox_api_token_id" { type = string }
variable "proxmox_api_token_secret" { type = string }

variable "sshkeys" { 
  type = string
  sensitive = true
}

variable "vm_configs" {
  type = map(object({
    vm_id              = number
    name               = string
    memory             = number
    vm_state           = string
    start_at_node_boot = bool
    startup_order      = number
    ipconfig           = string
    ciuser             = string
    cipassword         = string
    cores              = number
    bridge             = string
    network_tag        = number
  }))
  default = {
    "net-01" = {
      vm_id              = 200
      name               = "net-01"
      memory             = 4096
      vm_state           = "stopped"
      start_at_node_boot = false
      startup_order      = 1
      ipconfig           = "ip=192.168.1.200/24,gw=192.168.1.1"
      ciuser             = "automaton"
      cipassword         = "cvbn"
      cores              = 4
      bridge             = "vmbr0"
      network_tag        = 0
    },
  }
}
variable target_node { 
    description = "Name of Proxmox node to provision LXC on, e.g. `pve`."
    type        = string
}

variable vmid {
    description = "ID number for new LXC. 0 for auto."
    type        = number
    default     = 0
}

variable os_template {
    description = "Template for LXC."
    type        = string
    default     = "local:vztmpl/ubuntu-24.04-standard_24.04-2_amd64.tar.zst"
}

variable os_type {
  description = "Container OS specific setup, uses setup scripts in `/usr/share/lxc/config/<ostype>.common.conf`."
  type        = string
  default     = "unmanaged"
  validation {
    condition = contains(["alpine", "archlinux", "centos", "debian", "devuan", "fedora", "gentoo", "nixos", "opensuse", "ubuntu", "unmanaged"], var.os_type)
    error_message = "Invalid OS type setting."
  }
}

variable arch {
    description = "LXC OS architecture type."
    type        = string
    default     = "amd64"
}

variable description {
    description = "LXC description for PVE." 
    type        = string
    default     = null
}

variable tags {
    description = "LXC meta tags for PVE. e.g. terraform;test1;test2." 
    type        = string
    default     = null
}  

variable hostname {
    description = "FQHN for LXC."
    type        = string
    default     = null
}

variable root_password  {
    description = "Password for LXC root."
    sensitive   = true
    type        = string
    default     = null
}

variable ssh_pubkey   {
    description = "Public SSH Keys for LXC user."
    sensitive   = true
    type        = string
    default     = null
} 

variable unprivileged {
    description = "Set container to unprivileged."
    type        = bool
    default     = true
}

variable start_on_boot { 
    description = "Start the LXC on PVE boot."
    type        = bool
    default     = false
}

variable start_after_creation {
    description = "Start the LXC after creation."
    type        = bool
    default     = true
}

variable cores {
    description = "Amount of vCPU"
    type        = number
    default     = 1
}

variable memory {
    description = "Memory size in MiB"
    type        = number
    default     = 512    
}  

variable swap { 
    description = "Swap size in MiB"
    type        = number
    default     = 512    
}

variable storage { 
    description = "Disk storage location."
    type        = string
    default     = "local-lvm"
}

variable disk_size {
    type    = string
    default = "5G"
}

variable nameserver   { 
    description = "DNS server IP"
    type        = string
    default     = "192.168.1.1"
}

variable searchdomain {
    description = "DNS search domain"
    type        = string
    default     = "home.arpa"
}

variable vnic_name {
  description = "Networking adapter name."
  type        = string
  default     = "eth0"
}

variable vnic_bridge { 
    description = "Networking adapter bridge, e.g. `vmbr0`."
    type        = string
    default     = "vmbr0"   
}

variable ipv4_address {
    description = "Defaults to DHCP, for static IPv4 address set CIDR."
    type        = string
    default     = "dhcp"
}

variable ipv4_gateway { 
    description = "Defaults to DHCP, for static IPv4 gateway set IP address."
    type        = string
    default     = null
}  

variable firewall {
    description = "Enable the firewall on the network interface."
    type        = bool
    default     = true
}

variable features_nesting { 
    type = bool
    default = false 
}

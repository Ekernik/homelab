locals {
  ssh_public_key = file("~/.ssh/id_rsa.pub")
}

variable lxc_root_password { 
  description = "Pulled from secrets.auto.tfvars"
  sensitive   = true
  type        = string
}
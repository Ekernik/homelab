locals {
  hosts = {
    dns1       = { ip = module.technitium_dns_lxc.ipv4 }
    npmplus    = { ip = module.nginx_proxy_manager_plus_lxc.ipv4 }
    prometheus = { ip = module.prometheus_lxc.ipv4 }
  }
}

resource "local_file" "ansible_inventory" {
  filename = "${path.module}/terraform_inventory.ini"
  content  = templatefile("${path.module}/terraform_inventory.tmpl", {
    hosts = local.hosts
  })
}

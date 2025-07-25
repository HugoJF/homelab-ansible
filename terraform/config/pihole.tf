provider "pihole" {
  url      = "https://pihole.hugo.dev.br"
  password = var.pihole_password
}

resource "pihole_dns_record" "record" {
  for_each = {
    for service in local.private_services : service.hostname => service
  }

  domain = each.key
  ip     = var.arcade_ip
}
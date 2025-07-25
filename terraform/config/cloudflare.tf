provider "cloudflare" {
  api_token = var.cloudflare_api_token
}

data "cloudflare_zone" "cloudflare_zone" {
  zone_id = var.cloudflare_zone_id
}

resource "cloudflare_zero_trust_tunnel_cloudflared" "cloudflare_arcade_tunnel" {
  account_id = var.cloudflare_account_id
  config_src = "cloudflare"
  name       = "Arcade Tunnel"
}

locals {
  cloudflare_tunnel_ingress = [
    for service in local.public_services : {
      hostname : service.hostname
      service : service.origin
    }
  ]

  cloudflare_tunnel_default = [
    {
      service = "http_status:404"
    }
  ]
}

resource "cloudflare_zero_trust_tunnel_cloudflared_config" "cloudflare_arcade_tunnel_config" {
  account_id = var.cloudflare_account_id
  tunnel_id  = cloudflare_zero_trust_tunnel_cloudflared.cloudflare_arcade_tunnel.id
  config = {
    ingress = concat(
      local.cloudflare_tunnel_ingress,
      local.cloudflare_tunnel_default
    )
  }
}

resource "cloudflare_dns_record" "dns" {
  for_each = {
    for ingress in local.cloudflare_tunnel_ingress : ingress.hostname => ingress
  }

  zone_id = var.cloudflare_zone_id
  name    = each.key
  type    = "CNAME"
  comment = "cloudflared record for ${each.key}"
  content = "${cloudflare_zero_trust_tunnel_cloudflared.cloudflare_arcade_tunnel.id}.cfargotunnel.com"
  proxied = true
  ttl     = 1
}
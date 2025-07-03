terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "5.6.0"
    }

    uptimerobot = {
      source  = "uptimerobot/uptimerobot"
      version = "1.0.0"
    }
  }
}

provider "uptimerobot" {
  api_key = var.uptimerobot_api_key
}

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


resource "cloudflare_zero_trust_tunnel_cloudflared_config" "cloudflare_arcade_tunnel_config" {
  account_id = var.cloudflare_account_id
  tunnel_id  = cloudflare_zero_trust_tunnel_cloudflared.cloudflare_arcade_tunnel.id
  config = {
    ingress = [
      {
        hostname = "ha.hugo.dev.br"
        service  = "http://localhost:8123"
      },
      {
        hostname = "grafana.hugo.dev.br"
        service  = "http://localhost:3000"
      }, {
        hostname = "ptero.hugo.dev.br"
        service  = "http://localhost:8999"
      }, {
        service : "http_status:404"
      }
    ]
  }
}

locals {
  services_that_need_dns = toset([
    for each in cloudflare_zero_trust_tunnel_cloudflared_config.cloudflare_arcade_tunnel_config.config.ingress :
    each if each.hostname != null
  ])
}

resource "cloudflare_dns_record" "dns" {
  for_each = {
    for ingress in local.services_that_need_dns : ingress.hostname => ingress
  }

  zone_id = var.cloudflare_zone_id
  name    = each.key
  type    = "CNAME"
  comment = "cloudflared record for ${each.key}"
  content = "${cloudflare_zero_trust_tunnel_cloudflared.cloudflare_arcade_tunnel.id}.cfargotunnel.com"
  proxied = true
  ttl     = 1
}

resource "uptimerobot_monitor" "cloudflared" {
  for_each = {
    for ingress in local.services_that_need_dns : ingress.hostname => ingress
  }

  name             = "Arcade Public Hostname - ${each.key}"
  type             = "HTTP"
  url              = "https://${each.key}"
  http_method_type = "GET"
  interval         = 300
}
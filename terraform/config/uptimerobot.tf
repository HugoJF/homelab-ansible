provider "uptimerobot" {
  api_key = var.uptimerobot_api_key
}

resource "uptimerobot_monitor" "cloudflared" {
  for_each = {
    for service in local.public_services : service.hostname => service
  }

  name             = "Arcade Public Hostname - ${each.key}"
  type             = "HTTP"
  url              = "https://${each.key}"
  http_method_type = "GET"
  interval         = 300
}
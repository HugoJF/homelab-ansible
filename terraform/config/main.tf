terraform {
  backend "local" {
    path = "../state/terraform.tfstate"
  }

  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "5.6.0"
    }

    uptimerobot = {
      source  = "uptimerobot/uptimerobot"
      version = "1.0.0"
    }

    pihole = {
      source  = "ryanwholey/pihole"
      version = "2.0.0-beta.1"
    }
  }
}





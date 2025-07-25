variable "cloudflare_api_token" {
  type      = string
  sensitive = true
}

variable "cloudflare_zone_id" {
  type        = string
  description = "The Cloudflare zone ID for the domain"
}

variable "cloudflare_account_id" {
  type        = string
  description = "The base Cloudflare account ID"

}
variable "uptimerobot_api_key" {
  type      = string
  sensitive = true
}

variable "pihole_password" {
  type      = string
  sensitive = true
}

variable "arcade_ip" {
    type        = string
    description = "The IP address of the Arcade server"
}

variable "services" {
  type = list(object({
    hostname = string
    origin  = string
    public   = bool
    local_dns = bool
  }))
  description = "List of services to deploy with their hostnames and URLs"
}
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
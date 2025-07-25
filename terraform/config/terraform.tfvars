cloudflare_api_token  = ""
cloudflare_zone_id    = ""
cloudflare_account_id = ""

uptimerobot_api_key = ""

arcade_ip = "192.168.15.6"

pihole_password = "potato123"

services = [
  {
    hostname         = "ha.hugo.dev.br"
    origin           = "http://localhost:8123"
    public           = true
    local_dns        = false
    docker_container = "homeassistant"
  }, {
    hostname         = "pihole.hugo.dev.br"
    origin           = "http://localhost:800"
    public           = true
    local_dns        = true
    docker_container = "pihole"
  }, {
    hostname         = "paperless.hugo.dev.br"
    origin           = "http://localhost:8000"
    public           = true
    local_dns        = false
    docker_container = "paperless-ngx-webserver-1"
  }, {
    hostname         = "grafana.hugo.dev.br"
    origin           = "http://localhost:3000"
    public           = true
    local_dns        = false
    docker_container = "grafana"
  }, {
    hostname         = "prometheus.hugo.dev.br"
    origin           = "http://localhost:9090"
    public           = false
    local_dns        = true
    docker_container = "prometheus"
  }, {
    hostname         = "octoprint.hugo.dev.br"
    origin           = "http://localhost:8081"
    public           = true
    local_dns        = true
    docker_container = "octoprint"
  }, {
    hostname         = "ptero.hugo.dev.br"
    origin           = "http://localhost:8999"
    public           = true
    local_dns        = false
    docker_container = "pterodactyl-panel-1"
  }, {
    hostname         = "lan.hugo.dev.br"
    origin           = "http://localhost:8840"
    public           = false
    local_dns        = true
    docker_container = "watch-your-lan-wyl-1"
  }, {
    hostname         = "syncthing.hugo.dev.br"
    origin           = "http://localhost:8384"
    public           = true
    local_dns        = true
    docker_container = "syncthing"
  }, {
    hostname         = "scrutiny.hugo.dev.br"
    origin           = "http://localhost:8912"
    public           = false
    local_dns        = true
    docker_container = "scrutiny"
  }, {
    hostname         = "firefly.hugo.dev.br"
    origin           = "http://localhost:6666"
    public           = false
    local_dns        = true
    docker_container = "firefly_iii_core"
  }
]
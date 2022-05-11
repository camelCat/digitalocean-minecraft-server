// https://slugs.do-api.dev/
image = "ubuntu-22-04-x64"
droplet_size = "s-2vcpu-4gb"
region = "ams3"

// change this
ssh_keys = [
  34396110,
  34396119
]

// change optionally
droplet_name = "minecraft-server"
tags = [
  "minecraft-server",
  "production"
]
backups = false

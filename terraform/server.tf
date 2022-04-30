resource "digitalocean_droplet" "minecraft" {
  image = var.image
  name = "${var.droplet_name}-${var.droplet_size}-${var.region}"
  size = var.droplet_size
  region = var.region
  backups = var.backups
  ssh_keys = var.ssh_keys
  tags = var.tags
  user_data = file("./script.bash")
}
output "ssh_command" {
    value = "ssh root@${digitalocean_droplet.minecraft.ipv4_address}"
}
output "server_ip" {
    value = digitalocean_droplet.minecraft.ipv4_address
}
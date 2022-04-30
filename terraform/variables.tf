variable "image" {}
variable "droplet_name" {}
variable "droplet_size" {}
variable "region" {}
variable "backups" {}
variable "ssh_keys" {
  type = list(number)
}
variable "tags" {
  type = list(string)
}
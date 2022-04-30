# Terraform Minecraft Server

## Pre-Requirites
1. Install Terraform
2. Create DigitalOcean Account
3. Add an SSH key to you DigitalOcean account
4. Create an access token in DigitalOcean and and assign it to DIGITALOCEAN_TOKEN environment variable (`export DIGITALOCEAN_TOKEN="xxxxxxxxxxxxxxx"`)
5. Install DigitalOcean's doctl command line tool and authenticate

## First-time setup
1. Use doctl to get the id of your ssh key (`doctl compute ssh-key list`)
2. Change the values in terraform/terraform.tfvars
3. Change the values of the first two variables in terraform/script.bash

## Usage
1. Create, start and connect to the server  – `source create.sh`
2. Destroy the server                       – `sh destroy.sh`

## Connecting to the server
When executing the `create.sh` script you get connected automatically
To connect to the server type `mc` into your command line
## Server commands
1. mc console (to exit the console press `CTRL+A` and `D`)
2. mc restart
3. mc stop
4. mc start
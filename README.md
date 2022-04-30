# Terraform Minecraft Server

## Pre-Requirites
1. Install Terraform
2. Create DigitalOcean Account
3. Create an access token in DigitalOcean and and assign it to DIGITALOCEAN_TOKEN environment variable (`export DIGITALOCEAN_TOKEN="xxxxxxxxxxxxxxx"`)
4. Install DigitalOcean's doctl command line tool and authenticate

## First-time setup
1. Change the values in terraform/terraform.tfvars
2. Change the values of the first two variables in terraform/script.bash

## Usage
1. Create, start and connect to the server  – `source create.sh`
2. Destroy the server                       – `sh destroy.sh`

## Server commands
1. mc console
2. mc restart
3. mc stop
4. mc start
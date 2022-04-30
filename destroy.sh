#!/bin/sh
ssh root@${MC_SERVER_IP} sh /mc-server/stop.sh
rsync -avz \
    --exclude '*.sh' \
    --exclude 'libraries' \
    --exclude 'logs' \
    --exclude 'versions' \
    --exclude 'cache' \
    --exclude 'server.jar' \
    --exclude 'eula.txt' \
    root@${MC_SERVER_IP}:/mc-server/* ./backup
terraform -chdir=terraform destroy --auto-approve
rm terraform/.terraform.tfstate* > /dev/null
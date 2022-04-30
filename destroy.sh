#!/bin/sh
source ~/.bashrc
if [ -z "$MC_SERVER_IP" ]; 
then echo "The server doesn't exist"; exit; fi
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
bash_line="export MC_SERVER_IP="
sed -i "/$bash_line/d" ~/.bashrc
bash_line="alias mc="
sed -i "/$bash_line/d" ~/.bashrc
rm terraform/.terraform.tfstate* > /dev/null
rm server-info.txt

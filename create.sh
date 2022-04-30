#!/bin/sh
source ~/.bashrc
terraform -chdir=terraform init
terraform -chdir=terraform apply --auto-approve

bash_line="export MC_SERVER_IP="
sed -i "/$bash_line/d" ~/.bashrc
bash_line="alias mc="
sed -i "/$bash_line/d" ~/.bashrc

export MC_SERVER_IP=$(terraform -chdir=terraform output -raw server_ip)
echo "export MC_SERVER_IP=$(terraform -chdir=terraform output -raw server_ip)" >> ~/.bashrc
alias mc="ssh root@${MC_SERVER_IP}"
echo "alias mc=\"ssh root@${MC_SERVER_IP}\"" >> ~/.bashrc
echo "$(terraform -chdir=terraform output -raw server_ip)" > server-info.txt


echo "Waiting for the server to initialize..."
until ssh root@${MC_SERVER_IP} true >/dev/null 2>&1; do sleep 5; done;
echo "Restoring Backup..."
rsync -avzW -e ./backup/* root@${MC_SERVER_IP}:/mc-server/
echo "Done!"
mc
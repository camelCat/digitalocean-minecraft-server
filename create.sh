#!/bin/bash
source ~/.bashrc

start=$(date +%s.%N)

echo "Creating the server..."
terraform -chdir=terraform init > /dev/null
terraform -chdir=terraform apply --auto-approve > /dev/null


export MC_SERVER_IP=$(terraform -chdir=terraform output -raw server_ip)
echo "export MC_SERVER_IP=$(terraform -chdir=terraform output -raw server_ip)" >> ~/.bashrc
echo "Set 'MC_SERVER_IP' environment variable to ${MC_SERVER_IP}"

alias mc="ssh root@${MC_SERVER_IP}"
echo "alias mc=\"ssh root@${MC_SERVER_IP}\"" >> ~/.bashrc
echo "Set 'mc' as an alias to 'ssh root@$${MC_SERVER_IP}'"

echo "$(terraform -chdir=terraform output -raw server_ip)" > server-info.txt
echo "Added ${MC_SERVER_IP} to the local file 'server-info.txt'"

while ! grep -q $MC_SERVER_IP ~/.ssh/known_hosts; do ssh-keyscan $MC_SERVER_IP >> ~/.ssh/known_hosts 2> /dev/null; done;
echo "Added ${MC_SERVER_IP} to known_hosts"

echo "Waiting for the server to initialize..."
until ssh root@${MC_SERVER_IP} true >/dev/null 2>&1; do sleep 1; done;

echo "Restoring Backup..."
rsync -avzW ./backup/* root@${MC_SERVER_IP}:/mc-server/ > /dev/null 2> /dev/null

echo "Waiting for cloud-init to finish..."
while ! [ $(mc tail -n 1 /root/.bashrc) = "#Done" ]; do sleep 1; done;

duration=$(echo "$(date +%s.%N) - $start" | bc)
execution_time=`printf "%.2f seconds" $duration`
echo "Script Execution Time: $execution_time

"
mc
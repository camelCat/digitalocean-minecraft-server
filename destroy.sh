#!/bin/bash
if [ -z "$MC_SERVER_IP" ]; 
then 
echo "The server doesn't exist"; 
exit; 
fi

start=$(date +%s.%N)

echo "Stopping the server..."
ssh root@${MC_SERVER_IP} sh /mc-server/stop.sh
while ssh root@${MC_SERVER_IP} screen -list | grep -q "papermc"; do sleep 1; done;

echo "Backing up server files..."
rsync -avz \
    --exclude '*.sh' \
    --exclude 'libraries' \
    --exclude 'logs' \
    --exclude 'versions' \
    --exclude 'cache' \
    --exclude 'server.jar' \
    --exclude 'eula.txt' \
    root@${MC_SERVER_IP}:/mc-server/* ./backup > /dev/null

echo "Destroying the server..."
terraform -chdir=terraform destroy --auto-approve > /dev/null

echo "Removing ${MC_SERVER_IP} from known_hosts"
sed -i "/$MC_SERVER_IP/d" ~/.ssh/known_hosts

rm server-info.txt

echo "Removing 'MC_SERVER_IP' variable"
unset MC_SERVER_IP
bash_line="export MC_SERVER_IP="
sed -i "/$bash_line/d" ~/.bashrc

echo "Unsetting 'mc' alias"
unalias mc 2> /dev/null
bash_line="alias mc="
sed -i "/$bash_line/d" ~/.bashrc

duration=$(echo "$(date +%s.%N) - $start" | bc)
execution_time=`printf "%.2f seconds" $duration`
echo "Script Execution Time: $execution_time"

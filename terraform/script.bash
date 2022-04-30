#!/bin/bash
ALLOCATED_MEMORY="3" # GB (Allocate approximately 75% or your server ram)
PAPER_LINK="https://papermc.io/api/v2/projects/paper/versions/1.18.2/builds/313/downloads/paper-1.18.2-313.jar" # https://papermc.io/downloads

# Change this if you don't use Ubuntu or need another JRE version
sudo apt-get install -y openjdk-17-jre




# Don't touch
SPATH="/mc-server" # Server Directory
mkdir ${SPATH}
git config --global --unset core.autocrlf
wget $PAPER_LINK -O ${SPATH}/server.jar

echo "eula=true" > ${SPATH}/eula.txt

echo "screen -r papermc" > ${SPATH}/console.sh

cat > ${SPATH}/start.sh <<EOF 
#!/bin/sh
screen -d -m -S "papermc" java -Xms${ALLOCATED_MEMORY}G -Xmx${ALLOCATED_MEMORY}G -XX:+UseG1GC -jar ${SPATH}/server.jar nogui
EOF

cat > ${SPATH}/stop.sh <<EOF
#!/bin/sh
screen -S papermc -p 0 -X stuff "^C"
EOF

cat > ${SPATH}/restart.sh <<EOF
#!/bin/sh
screen -S papermc -p 0 -X stuff "^C"
screen -d -m -S "papermc" java -Xms${ALLOCATED_MEMORY}G -Xmx${ALLOCATED_MEMORY}G -XX:+UseG1GC -jar ${SPATH}/server.jar nogui
EOF
echo "exit" > ${SPATH}/exit

cat >> /root/.bashrc <<'EOF'
mc() {
    COMMAND=$1
    cd /mc-server
    sh ${COMMAND}.sh
}
if ! screen -list | grep -q "papermc"; then
    mc start
fi
cd /mc-server
echo "Welcome to your Minecraft Server directory"
echo "The server has been started automatically"
echo "Commands:"
echo "mc console"
echo "mc restart"
echo "mc stop"
echo "mc start"

EOF

chmod +x ${SPATH}*.sh
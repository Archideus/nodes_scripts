#!/bin/bash
echo "================================================================================"
echo -e "\033[0;35m"
echo "######## ######## ######## ######## ######## ######## ######## ######## ########";
echo "###  ### #     ## ##    ## #  ##  # ##    ## #    ### #      # #  ##  # ##    ##";
echo "##    ## #  ##  # #  ##  # #  ##  # ###  ### #  #  ## #  ##### #  ##  # #  ##  #";
echo "#  ##  # #  ##  # #  ##### #      # ###  ### #  ##  # #    ### #  ##  # #    ###";
echo "#      # #     ## #  ##### #  ##  # ###  ### #  ##  # #  ##### #  ##  # ####   #";
echo "#  ##  # #  #  ## #  ##  # #  ##  # ###  ### #  #  ## #  ##### #  ##  # #  ##  #";
echo "#  ##  # #  ##  # ##    ## #  ##  # ##    ## #    ### #      # ##    ## ##    ##";
echo "######## ######## ######## ######## ######## ######## ######## ######## ########";
echo -e "\e[0m"
echo "================================================================================"

sleep 2

exists()
{
  command -v "$1" >/dev/null 2>&1
}
if exists curl; then
  echo ''
else
  sudo apt update && sudo apt install curl -y < "/dev/null"
fi
bash_profile=$HOME/.bash_profile
if [ -f "$bash_profile" ]; then
    . $HOME/.bash_profile
fi

echo -e "\e[1m\e[32m1. Updating dependencies... \e[0m" && sleep 1
sudo apt update
echo -e "\e[1m\e[32m2. Install git unzip... \e[0m" && sleep 1
sudo apt install git unzip -y

if exists wget; then
  echo ''
else
echo -e "\e[1m\e[32m2.1 Installing wget... \e[0m" && sleep 1
sudo apt install wget -y
echo "=================================================="
fi
#install docker
if exists docker; then
	echo -e "\e[1m\e[32m3. Docker exists \e[0m" 
else
	echo -e "\e[1m\e[32m3. Install docker... \e[0m" && sleep 1
	curl -fsSL https://get.docker.com -o get-docker.sh
	sudo sh get-docker.sh
fi
#install docker-compose
if exists docker-compose; then
	echo -e "\e[1m\e[32m4. Docker-compose exists \e[0m" 
else
	echo -e "\e[1m\e[32m4. Installing docker-compose... \e[0m" && sleep 1
	curl -SL https://github.com/docker/compose/releases/download/v2.5.0/docker-compose-linux-x86_64 -o /usr/local/bin/docker-compose
	sudo chmod +x /usr/local/bin/docker-compose
	sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
fi

SNAPSHOT='gemini-1a-2022-may-31'
#Read credentials
if [ ! $ADDRESS ]; then
echo -e "\e[1m\e[32m5. Enter Polkadot JS address to receive rewards \e[0m"
read -p "Address: " ADDRESS
echo "=================================================="
echo 'export ADDRESS='\"${ADDRESS}\" >> $HOME/.bash_profile
fi
if [ ! $NODE_NAME ]; then
echo -e "\e[1m\e[32m6. Enter Subspace Node name \e[0m"
read -p "Node Name : " NODE_NAME
echo "=================================================="
echo 'export NODE_NAME='\"${NODE_NAME}\" >> $HOME/.bash_profile
fi
if [ ! $PLOTSIZE ]; then
echo -e "\e[1m\e[32m67. Enter Subspace Farmer Plot Size. For example 30G (means 30 Gigabyte) \e[0m"
read -p "Plot Size : " PLOTSIZE
echo "=================================================="
echo 'export PLOTSIZE='\"${PLOTSIZE}\" >> $HOME/.bash_profile
fi
echo -e "\e[1m\e[92m Node Name: \e[0m" $NODE_NAME
echo -e "\e[1m\e[92m Address:  \e[0m" $ADDRESS
echo -e "\e[1m\e[92m Plot Size:  \e[0m" $PLOTSIZE

echo 'source $HOME/.bashrc' >> $HOME/.bash_profile
. $HOME/.bash_profile

#create folder,download config    
IPADDR=$(curl ifconfig.me) 
sleep 2   
mkdir -p $HOME/Subspace
cd $HOME/Subspace
rm docker-compose.yml

echo 'version: "3.7"
services:
  node:
    image: ghcr.io/subspace/node:'$SNAPSHOT'
    volumes:
      - node-data:/var/subspace:rw
#      - /path/to/subspace-node:/var/subspace:rw
    ports:
      - "0.0.0.0:30333:30333"
    restart: unless-stopped
    command: [
      "--chain", "gemini-1",
      "--base-path", "/var/subspace",
      "--execution", "wasm",
      "--pruning", "1024",
      "--keep-blocks", "1024",
      "--port", "30333",
      "--rpc-cors", "all",
      "--rpc-methods", "safe",
      "--unsafe-ws-external",
      "--validator",
      "--name", '\"$NODE_NAME\"'
    ]
    healthcheck:
      timeout: 5s
      interval: 30s
      retries: 5

  farmer:
    depends_on:
      node:
        condition: service_healthy
    image: ghcr.io/subspace/farmer:'$SNAPSHOT'
    volumes:
      - farmer-data:/var/subspace:rw
#      - /path/to/subspace-farmer:/var/subspace:rw
    restart: unless-stopped
    command: [
      "--base-path", "/var/subspace",
      "farm",
      "--node-rpc-url", "ws://node:9944",
      "--ws-server-listen-addr", "0.0.0.0:9955",
      "--reward-address",'\"$ADDRESS\"',
      "--plot-size", '\"$PLOTSIZE\"'
    ]
volumes:
  node-data:
  farmer-data:' >> ./docker-compose.yml

docker-compose up -d
sleep 1
docker-compose logs --tail=1000 -f

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
#Read credentials 
IPADDR=$(curl ifconfig.me) 
if [ ! $SNAPSHOT ]; then
SNAPSHOT='gemini-1b-2022-june-02'
echo "=================================================="
echo 'export SNAPSHOT='\"${SNAPSHOT}\" >> $HOME/.bash_profile
fi
if [ ! $ADDRESS ]; then
echo -e "\e[1m\e[32m5. Enter Polkadot JS address \e[0m"
read -p "Address: " ADDRESS
echo "=================================================="
echo 'export ADDRESS='\"${ADDRESS}\" >> $HOME/.bash_profile
fi
if [ ! $NODE_NAME ]; then
echo -e "\e[1m\e[32m6. Enter Subspace Node name that will be shown in telemetry (doesn't impact anything else)\e[0m"
read -p "Node Name : " NODE_NAME
echo "=================================================="
echo 'export NODE_NAME='\"${NODE_NAME}\" >> $HOME/.bash_profile
fi
if [ ! $PLOTSIZE ]; then
echo -e "\e[1m\e[32m67. Enter Subspace Farmer Plot Size with plot size in gigabytes or terabytes, for instance 100G or 2T (but leave at least 10G of disk space for node) For example 100G (means 100 Gigabyte) \e[0m"
read -p "Plot Size : " PLOTSIZE
echo "=================================================="
echo 'export PLOTSIZE='\"${PLOTSIZE}\" >> $HOME/.bash_profile
fi
echo -e "\e[1m\e[92m Node Name: \e[0m" $NODE_NAME
echo -e "\e[1m\e[92m Polkadot Address:  \e[0m" $ADDRESS
echo -e "\e[1m\e[92m Plot Size:  \e[0m" $PLOTSIZE
echo -e "\e[1m\e[92m Curent Snapshot:  \e[0m" $SNAPSHOT

echo 'source $HOME/.bashrc' >> $HOME/.bash_profile
. $HOME/.bash_profile

#create folder,download config   
sleep 2   
mkdir -p $HOME/subspace
cd $HOME/subspace
if [ -f "docker-compose.yml" ]; then
  rm docker-compose.yml
fi
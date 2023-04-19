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

timedatectl | grep "System clock"

sleep 1

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
source $HOME/.bash_profile

echo -e "\e[1m\e[32m1. Updating dependencies... \e[0m" && sleep 1
sudo apt update

echo "=================================================="

if exists wget; then
  echo ''
else
echo -e "\e[1m\e[32m2. Installing wget... \e[0m" && sleep 1
sudo apt install wget -y

echo "=================================================="
fi

cd $HOME
mkdir subspace
cd subspace
wget -O subspace-node https://github.com/subspace/subspace/releases/download/gemini-3d-2023-apr-18/subspace-node-ubuntu-x86_64-v3-gemini-3d-2023-apr-18
wget -O subspace-farmer https://github.com/subspace/subspace/releases/download/gemini-3d-2023-apr-18/subspace-farmer-ubuntu-x86_64-v3-gemini-3d-2023-apr-18
sudo chmod +x subspace-node
sudo chmod +x subspace-farmer
sudo mv subspace-node /usr/local/bin/
sudo mv subspace-farmer /usr/local/bin/


source ~/.bash_profile
sleep 1

echo "=================================================="

if [ ! $ADDRESS ]; then
echo -e "\e[1m\e[32m5. Enter Subspace wallet address to receive rewards \e[0m"
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

echo -e "\e[1m\e[91m    Continue the process (y/n) \e[0m"
read -p "(y/n)?" response
if [[ $response =~ ^(yes|y| ) ]] || [[ -z $response ]]; then
  echo "=================================================="

  echo -e "\e[1m\e[32m8. Creating service for Subspace Node \e[0m"


  echo "[Unit]
Description=Subspace Node

[Service]
User=$USER
ExecStart=subspace-node --chain gemini-3d --execution wasm --blocks-pruning archive --state-pruning archive --dsn-disable-private-ips --no-private-ipv4 --validator --name '$NODE_NAME'
Restart=always
RestartSec=10
LimitNOFILE=65535

[Install]
WantedBy=multi-user.target
    " > $HOME/subspace-node.service

    sudo mv $HOME/subspace-node.service /etc/systemd/system

    echo "=================================================="

    echo -e "\e[1m\e[32m9. Creating service for Subspace Farmer \e[0m"

    echo "[Unit]
Description=Subspace Farmer

[Service]
User=$USER
ExecStart=subspace-farmer farm --disable-private-ips --reward-address $ADDRESS --plot-size $PLOTSIZE
Restart=always
RestartSec=10
LimitNOFILE=65535

[Install]
WantedBy=multi-user.target
    " > $HOME/subspace-farmer.service

    sudo mv $HOME/subspace-farmer.service /etc/systemd/system

    echo "=================================================="

    # Enabling services
    sudo systemctl restart systemd-journald
    sudo systemctl daemon-reload
    sudo systemctl enable subspace-farmer.service
    sudo systemctl enable subspace-node.service

    # Starting services
    sudo systemctl restart subspace-node.service
    sudo systemctl restart subspace-farmer.service

    echo "=================================================="

    echo -e "\e[1m\e[32mNode Started \e[0m"
    echo -e "\e[1m\e[32mFarmer Started \e[0m"

    echo "=================================================="

    echo -e "\e[1m\e[32mTo stop the Subspace Node: \e[0m" 
    echo -e "\e[1m\e[39m    systemctl stop subspace-node.service \n \e[0m" 

    echo -e "\e[1m\e[32mTo start the Subspace Node: \e[0m" 
    echo -e "\e[1m\e[39m    systemctl start subspace-node.service \n \e[0m" 

    echo -e "\e[1m\e[32mTo check the Subspace Node Logs: \e[0m" 
    echo -e "\e[1m\e[39m    journalctl -u subspace-node.service -f \n \e[0m" 

    echo -e "\e[1m\e[32mTo stop the Subspace Farmer: \e[0m" 
    echo -e "\e[1m\e[39m    systemctl stop subspace-farmer.service \n \e[0m" 

    echo -e "\e[1m\e[32mTo start the Subspace Farmer: \e[0m" 
    echo -e "\e[1m\e[39m    systemctl start subspace-farmer.service \n \e[0m" 

    echo -e "\e[1m\e[32mTo check the Subspace Farmer signed block logs: \e[0m" 
    echo -e "\e[1m\e[39m    journalctl -u subspace-farmer.service -o cat | grep 'Successfully signed reward hash' \n \e[0m" 

    echo -e "\e[1m\e[32mTo check the Subspace Farmer default logs: \e[0m" 
    echo -e "\e[1m\e[39m    journalctl -u subspace-farmer.service -f \n \e[0m" 
else
    echo -e "\e[1m\e[91m    You have terminated the process \e[0m"
fi

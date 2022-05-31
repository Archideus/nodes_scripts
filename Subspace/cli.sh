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

echo -e "\e[1m\e[91mNOTE. This step is only for those who used previously our script to run the node!!!"
echo -e "If you have used a different setup to start node/farmer then terminate this process CTRL+C, stop the node/farmer and wipe the old data before continuing!!! \e[0m"
echo -e "\e[1m\e[91mOfficial Guide: https://github.com/subspace/subspace/blob/main/docs/farming.md#switching-to-a-new-snapshot \e[0m"
echo -e "./FARMER_FILE_NAME wipe"
echo -e "./NODE_FILE_NAME purge-chain --chain testnet \n"

echo -e "\e[1m\e[91m3. If you were running a node previously, and want to switch to a new snapshot we need to cleanup old data. Please confirm (y/n) \e[0m"
read -p "(y/n)?" response
if [[ $response =~ ^(yes|y| ) ]] || [[ -z $response ]]; then   
    sudo systemctl stop subspace-farmer.service
    sudo systemctl stop subspace-node.service
    subspace-farmer wipe
    subspace-node purge-chain -y --chain testnet
fi
echo "=================================================="

cd $HOME
rm -rf subspace*
wget -O subspace-node https://github.com/subspace/subspace/releases/download/gemini-1a-2022-may-31/subspace-node-ubuntu-x86_64-gemini-1a-2022-may-31
wget -O subspace-farmer https://github.com/subspace/subspace/releases/download/gemini-1a-2022-may-31/subspace-farmer-ubuntu-x86_64-gemini-1a-2022-may-31
chmod +x subspace*
mv subspace* /usr/local/bin/

source ~/.bash_profile
sleep 1

echo "=================================================="

echo -e "\e[1m\e[32m4. Enter Polkadot JS address to receive rewards \e[0m"
read -p "Address: " ADDRESS

echo "=================================================="

echo -e "\e[1m\e[32m5. Enter Subspace Node name \e[0m"
read -p "Node Name : " NODE_NAME

echo "=================================================="

echo -e "\e[1m\e[32m6. Enter Subspace Farmer Plot Size. For example 30G (means 30 Gigabyte) \e[0m"
read -p "Plot Size : " PLOTSIZE

echo "=================================================="

echo -e "\e[1m\e[92m Node Name: \e[0m" $NODE_NAME

echo -e "\e[1m\e[92m Address:  \e[0m" $ADDRESS

echo -e "\e[1m\e[92m Plot Size:  \e[0m" $PLOTSIZE

echo -e "\e[1m\e[91m    7 Continue the process (y/n) \e[0m"
read -p "(y/n)?" response
if [[ $response =~ ^(yes|y| ) ]] || [[ -z $response ]]; then
  echo "=================================================="

  echo -e "\e[1m\e[32m8. Creating service for Subspace Node \e[0m"

  echo "[Unit]
Description=Subspace Node

[Service]
User=$USER
ExecStart=subspace-node --chain gemini-1 --execution native --pruning 1024 --keep-blocks 1024 --validator --name '$NODE_NAME' --telemetry-url 'wss://telemetry.subspace.network/submit 0'
Restart=always
RestartSec=10
LimitNOFILE=10000

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
ExecStart=subspace-farmer farm --reward-address $ADDRESS --plot-size $PLOTSIZE
Restart=always
RestartSec=10
LimitNOFILE=10000

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

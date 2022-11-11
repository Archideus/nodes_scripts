#!/usr/bin/env bash
set -e

echo "===================================================================="
echo -e "\033[0;35m"
echo " #####  ######   #####  ##   ## #### ######  ####### ##   ##  ##### ";
echo "##   ## ##   ## ##   ## ##   ##  ##  ##   ## ##      ##   ## ##   ##";
echo "##   ## ##   ## ##      ##   ##  ##  ##   ## ##      ##   ## ##     ";
echo "####### ######  ##      #######  ##  ##   ## #####   ##   ##  ##### ";
echo "##   ## ##   ## ##      ##   ##  ##  ##   ## ##      ##   ##      ##";
echo "##   ## ##   ## ##   ## ##   ##  ##  ##   ## ##      ##   ## ##   ##";
echo "##   ## ##   ##  #####  ##   ## #### ######  #######  #####   ##### ";
echo -e "\e[0m"
echo "===================================================================="
sleep 2

exists()
{
  command -v "$1" >/dev/null 2>&1
}
if exists curl; then
  echo ''
else
	echo -e "\e[1m\e[32m2. Installing curl... \e[0m" && sleep 1
  sudo apt update && sudo apt install curl -y < "/dev/null"
fi

if [ ! $MINIMAUIID ]; then
  read -p "Enter minima ID: " MINIMAUIID
  echo 'export MINIMAUIID='$MINIMAUIID >> $HOME/.bash_profile
fi
. $HOME/.bash_profile

sudo rm -r /home/minima/

echo -e "\e[1m\e[32m2. Creating user minima... \e[0m" && sleep 1
sudo adduser minima -y
sudo usermod -aG sudo minima
echo -e "\e[1m\e[32m2. Switch to user minima... \e[0m" && sleep 1
su - minima
echo -e "\e[1m\e[32m2. Download the docker install script: \e[0m" && sleep 1
sudo curl -fsSL https://get.docker.com/ -o get-docker.sh
echo -e "\e[1m\e[32m2. Give the script permissions and run the installer for docker - this will take a few minutes to finish: \e[0m" && sleep 1
sudo chmod +x ./get-docker.sh && ./get-docker.sh

echo -e "\e[1m\e[32m2. Add the minima user to the Docker group: \e[0m" && sleep 1
sudo usermod -aG docker $USER

echo -e "\e[1m\e[32m2. Exit back to original user: and Switch to minima user to refresh the groups: \e[0m" && sleep 1
exit
su - minima
if [ ! $MINIDAPPPASS ]; then
  read -p "Enter MiniDapp hub pass: " MINIDAPPPASS
  echo 'export MINIDAPPPASS='$MINIDAPPPASS >> $HOME/.bash_profile
fi
. $HOME/.bash_profile

echo -e "\e[1m\e[32m2. Starting node \e[0m" && sleep 1
docker run -d -e minima_mdspassword=$MINIDAPPPASS -e minima_server=true -v ~/minimadocker9001:/home/minima/data -p 9001-9004:9001-9004 --restart unless-stopped --name minima9001 minimaglobal/minima:latest
echo -e "\e[1m\e[32m2. Setup autostart docker \e[0m" && sleep 1
sudo systemctl enable docker.service
sudo systemctl enable containerd.service

echo -e "\e[1m\e[32m2. Add ID to node via Minima hub \e[0m" && sleep 1
docker exec -it minima9001 minima
incentivecash uid:$MINIMAUIID
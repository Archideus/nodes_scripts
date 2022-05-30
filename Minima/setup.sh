#!/bin/sh
echo "=================================================="
echo -e "\033[0;35m"
echo " #####  ######   #####  ##   ## #### ######  ####### ##   ##  ##### ";
echo "##   ## ##   ## ##   ## ##   ##  ##  ##   ## ##      ##   ## ##   ##";
echo "##   ## ##   ## ##      ##   ##  ##  ##   ## ##      ##   ## ##     ";
echo "####### ######  ##      #######  ##  ##   ## #####   ##   ##  ##### ";
echo "##   ## ##   ## ##      ##   ##  ##  ##   ## ##      ##   ##      ##";
echo "##   ## ##   ## ##   ## ##   ##  ##  ##   ## ##      ##   ## ##   ##";
echo "##   ## ##   ##  #####  ##   ## #### ######  #######  #####   ##### ";
echo -e "\e[0m"
echo "=================================================="
sleep 2

set -e

CLEAN_FLAG=''
PORT=''
HOST=''
HOME="/home/minima"
CONNECTION_HOST=''
CONNECTION_PORT=''
SLEEP=''
RPC=''

print_usage() {
  printf "Usage: Setups a new minima service for the specified port"
}

while getopts ':xsc::p:r:d:h:' flag; do
  case "${flag}" in
    s) SLEEP='true';;
    x) CLEAN_FLAG='true';;
    r) RPC="${OPTARG}";;
    c) CONNECTION_HOST=$(echo $OPTARG | cut -f1 -d:);
       CONNECTION_PORT=$(echo $OPTARG | cut -f2 -d:);;
    p) PORT="${OPTARG}";;
    d) HOME="${OPTARG}";;
    h) HOST="${OPTARG}";;
    *) print_usage
       exit 1 ;;
  esac
done

if [ ! $MINIMAUIID ]; then
  read -p "Enter minima ID name: " MINIMAUIID
  echo 'export MINIMAUIID='$MINIMAUIID >> $HOME/.bash_profile
fi
source $HOME/.bash_profile

apt update
sudo apt install curl -y
sudo apt install jq -y
apt install openjdk-11-jre-headless curl jq -y

if [ ! $(getent group minima) ]; then
  echo "[+] Adding minima group"
  groupadd -g 9001 minima
fi

if ! id -u 9001 > /dev/null 2>&1; then
  echo "[+] Adding minima user"
    useradd -r -u 9001 -g 9001 -d $HOME minima
    mkdir $HOME
    chown minima:minima $HOME
fi

wget -q -O $HOME"/minima_service.sh" "https://raw.githubusercontent.com/Archideus/nodes_scripts/main/Minima/minima_service.sh"
chown minima:minima $HOME"/minima_service.sh"
chmod +x $HOME"/minima_service.sh"

CMD="$HOME/minima_service.sh -s $@"
CRONSTRING="#!/bin/sh
$CMD"

echo "$CRONSTRING" > /etc/cron.weekly/minima_$PORT
chmod a+x /etc/cron.weekly/minima_$PORT

CMD="$HOME/minima_service.sh $@"
/bin/sh -c "$CMD"

curl 127.0.0.1:9002/incentivecash%20uid:$MINIMAUIID

echo "Install complete - showing logs now -  Ctrl-C to exit logs, minima will keep running"
journalctl -fn 10 -u minima_$PORT
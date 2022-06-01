# OASIS

## Install
Use our script for a quick installation:
```sh
wget -q -O oasys.sh https://raw.githubusercontent.com/Archideus/nodes_scripts/main/Oasis/oasys.sh && chmod +x oasys.sh && sudo /bin/bash oasys.sh
```
## Additional
###You can check the node logs with the command:
```sh
journalctl -u oasysd -f
```
###Restart node:
```sh
systemctl restart oasysd
```
###The progress of synchronization can be checked with the following command. Synchronization is complete when the output changes to false.
```sh
sudo -u geth geth attach ipc:/home/geth/.ethereum/geth.ipc --exec eth.syncing
```
###Delete node:
```sh
systemctl stop oasysd
systemctl disable oasysd
rm -rf /home/geth/*
rm /etc/systemd/system/oasysd.service
```
Ports used:

TCP/UDP port 30303
TCP port 8545
# StarkNet (https://api.nodes.guru/wp-content/uploads/2022/03/StarkNet_Icon.png)

## System Requirements

CPU	4CPU
RAM	4GB
Storage	100GB+
OS	Ubuntu 20.04 LTS

## 1.Installing

Use our script for a quick installation:
```sh
wget -O starknet.sh https://raw.githubusercontent.com/Archideus/nodes_scripts/main/StarkNet/starknet.sh && chmod +x starknet.sh && ./starknet.sh
```

## 2. Endpoints
To run starknet we will use the nodes provided by the [Alchemy](https://alchemy.com/?r=cf7a724f05e2bf08) service, so register at alchemy.com and create endpoints in your personal account.

## 3.Additional
Check logs:
```sh
journalctl -u starknetd -f
```
Restart node:
```sh
systemctl restart starknetd
```
Delete node:
```sh
systemctl stop starknetd
systemctl disable starknetd
rm -rf ~/pathfinder/
rm -rf /etc/systemd/system/starknetd.service
rm -rf /usr/local/bin/pathfinder
```
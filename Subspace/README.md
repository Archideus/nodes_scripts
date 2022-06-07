# ![alt text](https://assets.website-files.com/61526a2af87a54e565b0ae92/6155fc8597a1468aa6dfba07_Group%20201.svg)
## Install Subspace Node and Farmer


## Recomended Subspace Hardware

- 2 Cores (modern CPU's)
- 2GB RAM
- 50GB of storage (SSD or NVME)

## First you need register and create wallet on [Polkadot](https://polkadot.js.org/apps/?rpc=wss%3A%2F%2Ffarm-rpc.subspace.network%2Fws#/accounts)


## CLI

```sh
wget -O subspace.sh https://raw.githubusercontent.com/Archideus/nodes_scripts/main/Subspace/cli.sh && chmod +x subspace.sh && sudo ./subspace.sh
```


## Docker

Subspace is very easy to install and deploy in a Docker container.

```sh
wget -O subspace.sh https://raw.githubusercontent.com/Archideus/nodes_scripts/main/Subspace/docker.sh && chmod +x subspace.sh && sudo ./subspace.sh
```

### Useful Commands (Docker)
!Note first go to Subspace folder contained docker-compose.yml

```sh
cd $HOME/Subspace
```

You can read logs with: 
```sh
docker-compose logs --tail=1000 -f
```
Node logs with: 
```sh
docker-compose logs --tail=1000 -f node
```
Farmer logs with: 
```sh
docker-compose logs --tail=1000 -f farmer
```
To stop docker: 
```sh
docker-compose down -v
```
To start everything Go to directory with docker-compose.yml and type: 
```sh
docker-compose up -d 
```

## Useful Commands (CLI)

Check sync:
```sh
curl -H "Content-Type: application/json" -d '{"id":1, "jsonrpc":"2.0", "method": "system_health", "params":[]}' http://localhost:9933/
```

To see status of Subspace Node: 
```sh
systemctl status subspace-node.service 
```

To stop the Subspace Node: 
```sh
systemctl stop subspace-node.service 
```
 
To start the Subspace Node: 
```sh
systemctl start subspace-node.service 
```
 
To check the Subspace Node Logs: 
```sh
journalctl -u subspace-node.service -f 
```

To see status of Subspace Farmer: 
```sh
systemctl status subspace-farmer.service 
```

To stop the Subspace Farmer: 
```sh
systemctl stop subspace-farmer.service 
```

To start the Subspace Farmer: 
```sh
systemctl start subspace-farmer.service 
```

To check the Subspace Farmer signed block logs: 
```sh
journalctl -u subspace-farmer.service -o cat | grep 'Successfully signed block' 
```

To check the Subspace Farmer default logs: 
```sh
journalctl -u subspace-farmer.service -f 
journalctl -u subspace-farmer.service -f -o cat
```

Restart farmer: 
```sh
sudo systemctl daemon-reload
sudo systemctl enable subspace-farmer.service
sudo systemctl restart subspace-farmer.service
```

Restart node: 
```sh
sudo systemctl restart systemd-journald
sudo systemctl daemon-reload
sudo systemctl enable subspace-node.service
sudo systemctl restart subspace-node.service
```
##Update node peers CLI
```sh
wget -O update_peers.sh https://raw.githubusercontent.com/Archideus/nodes_scripts/main/Subspace/update_peers.sh && chmod +x update_peers.sh && sudo ./update_peers.sh
```


##Delete node



# ![alt text](https://assets.website-files.com/61526a2af87a54e565b0ae92/6155fc8597a1468aa6dfba07_Group%20201.svg)
## Install Subspace Node and Farmer


## Recomended Subspace Hardware

- 2 Cores (modern CPU's)
- 2GB RAM
- 50GB of storage (SSD or NVME)

## Register on [Polkadot](https://polkadot.js.org/apps/?rpc=wss%3A%2F%2Ffarm-rpc.subspace.network%2Fws#/accounts)


## CLI

```sh
wget -O subspace.sh https://raw.githubusercontent.com/Archideus/nodes_scripts/main/Subspace/cli.sh && chmod +x subspace.sh && sudo ./subspace.sh
```


## Docker

Subspace is very easy to install and deploy in a Docker container.

```sh
wget -O subspace.sh https://raw.githubusercontent.com/Archideus/nodes_scripts/main/Subspace/docker.sh && chmod +x subspace.sh && sudo ./subspace.sh
```


## Useful Commands (CLI)

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
```



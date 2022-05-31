# ![alt text](https://assets.website-files.com/61526a2af87a54e565b0ae92/6155fc8597a1468aa6dfba07_Group%20201.svg)
## _Install Subspace Node and Farmer


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

-Log in as the root user.
-Open the command prompt, ensure you are in the root directory

```sh
wget -O subspace.sh https://raw.githubusercontent.com/Archideus/nodes_scripts/main/Subspace/docker.sh && chmod +x subspace.sh && sudo ./subspace.sh
```


## Useful Commands

```sh
To stop the Subspace Node: 
    systemctl stop subspace-node.service 
 
To start the Subspace Node: 
    systemctl start subspace-node.service 
 
To check the Subspace Node Logs: 
    journalctl -u subspace-node.service -f 
 
To stop the Subspace Farmer: 
    systemctl stop subspace-farmer.service 
 
To start the Subspace Farmer: 
    systemctl start subspace-farmer.service 
 
To check the Subspace Farmer signed block logs: 
    journalctl -u subspace-farmer.service -o cat | grep 'Successfully signed block' 
 
To check the Subspace Farmer default logs: 
    journalctl -u subspace-farmer.service -f 

```

//Failed to connect to 127.0.0.1 port 9002: Connection refused
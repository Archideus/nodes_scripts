# ![alt text](https://assets.website-files.com/61526a2af87a54e565b0ae92/6155fc8597a1468aa6dfba07_Group%20201.svg)
## Install Subspace Node and Farmer for non-incentivized Stress Test

## Official documentation [Subspace doc](https://docs.subspace.network/protocol/farm/farming/)

## Recomended Subspace Hardware

Hardware | Specs
--- | ---
CPU | 2 Core+
RAM	| 4GB+ (Rec. 8GB)
Storage - Node | 60GB+
Storage - Plot | 4KB+


##Polkadot.js wallet
Before running anything you need to have a wallet where you'll receive testnet coins.

Install [Polkadot.js extension](https://forum.subspace.network/t/subspace-wallet/61) into your browser and create a new account there. The address of your account will be necessary at the last step.

For help refer to our forum post [How to setup a Polkadot.JS Wallet](https://forum.subspace.network/t/subspace-wallet/61)

## Docker

Subspace is very easy to install and deploy in a Docker container.

```sh
wget -O docker.sh https://raw.githubusercontent.com/Archideus/nodes_scripts/main/Subspace/non-incentivized/docker.sh && chmod +x docker.sh && sudo ./docker.sh
```

### Useful Commands (Docker), for the rest read [Docker Compose CLI reference](https://docs.docker.com/compose/reference/).
!Note first go to Subspace folder contained docker-compose.yml

```sh
cd $HOME/subspace
```
You can read logs with: 
```sh
docker-compose logs --tail=1000 -f
```
## Post Node & Farmer Install Care
Now that your Node & Farmer have been started you will wait for the node to sync and the farmer to complete the initial plotting. While this is occuring you can check out some of the helpful resources below.

- [Telemetry Server](https://telemetry.subspace.network/#/0x9ee86eefc3cc61c71a7751bba7f25e442da2512f408e6286153b3ccc055dccf0)

- [Block Explorer](https://polkadot.js.org/apps/?rpc=wss%3A%2F%2Feu.gemini-1b.subspace.network%2Fws#/explorer)



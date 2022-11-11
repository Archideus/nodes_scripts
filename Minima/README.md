# ![alt text](https://docs.minima.global/img/logo.svg) Minima
## _Install minima scripts directly to server or using docker_

## Recomended Minimum Hardware

- 1 Cores (modern CPU's)
- 1GB RAM
- 30GB of storage (SSD or NVME)

## Register on [Minima](https://incentive.minima.global/account/register?inviteCode=IJHJUQBR)

## Installation Linux VPS

-Log in as the root user.
-Open the command prompt, ensure you are in the root directory
-If you have any older versions of Minima installed, please uninstall them before moving to the next step. Please run this script to uninstall Minima:

## Uninstall Minima 

```sh
wget -O minima_remove.sh https://raw.githubusercontent.com/minima-global/Minima/master/scripts/minima_remove.sh && chmod +x minima_remove.sh && sudo ./minima_remove.sh -p 9001 -x
```
Second
```sh
wget -O minima_remove.sh https://raw.githubusercontent.com/minima-global/Minima/master/scripts/minima_remove.sh && chmod +x minima_remove.sh && sudo ./minima_remove.sh -p 9121 -x
```

## Install Minima 

on port 9001
Run in console on server
```sh
wget -O minima_setup.sh https://raw.githubusercontent.com/minima-global/Minima/master/scripts/minima_setup.sh && chmod +x minima_setup.sh && sudo ./minima_setup.sh -p 9001
```

Install second Minima on port 9122

```sh
wget -O minima_setup.sh https://raw.githubusercontent.com/minima-global/Minima/master/scripts/minima_setup.sh && chmod +x minima_setup.sh && sudo ./minima_setup.sh -p 9121
```

## Connect ID

```sh
curl 127.0.0.1:9005/incentivecash%20uid:<your id>

curl 127.0.0.1:9125/incentivecash%20uid:<your id>
```

## Docker
Minima is very easy to install and deploy in a Docker container.(soon)

### Uninstall Minima Cli if installed before
```sh
sudo wget -O minima_remove.sh https://raw.githubusercontent.com/minima-global/Minima/master/scripts/minima_remove.sh && chmod +x minima_remove.sh && sudo ./minima_remove.sh -p 9001 -x
```




## Useful Commands CLI

```sh
Stopping/starting Minima (Service must be called minima.service)
sudo systemctl stop minima_9001 : Stop the Minima service
sudo systemctl disable minima_9001 : Disable the Minima service
sudo systemctl enable minima_9001 : Enable the Minima service 
sudo systemctl start minima_9001 : Start the Minima service

Interacting with Minima
curl 127.0.0.1:9005/status | jq : shows the status of Minima 
curl 127.0.0.1:9005/incentivecash | jq : shows your incentive cash balance
curl 127.0.0.1:9005/help | jq : shows the full list of commands
```

second node
```sh
Stopping/starting Minima (Service must be called minima.service)
sudo systemctl stop minima_9121 : Stop the Minima service
sudo systemctl disable minima_9121 : Disable the Minima service
sudo systemctl enable minima_9121 : Enable the Minima service 
sudo systemctl start minima_9121 : Start the Minima service

Interacting with Minima
curl 127.0.0.1:9125/status | jq : shows the status of Minima 
curl 127.0.0.1:9125/incentivecash | jq : shows your incentive cash balance
curl 127.0.0.1:9125/help | jq : shows the full list of commands
```

## Firewall

```sh
ufw default allow
ufw deny in 9005
ufw deny in 9125
ufw allow ssh
ufw enable
```
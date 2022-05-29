# ![alt text](https://docs.minima.global/img/logo.svg) Minima
## _Install minima scripts directly to server or using docker_

## Recomended Minimum Hardware

- 1 Cores (modern CPU's)
- 1GB RAM
- 30GB of storage (SSD or NVME)

## Installation Linux VPS

-Log in as the root user.
-Open the command prompt, ensure you are in the root directory
-If you have any older versions of Minima installed, please uninstall them before moving to the next step. Please run this script to uninstall Minima:

```sh
wget -O minima_cleanup_v98.sh https://raw.githubusercontent.com/minima-global/Minima/master/scripts/minima_cleanup_v98.sh && chmod +x minima_cleanup_v98.sh && sudo ./minima_cleanup_v98.sh
```

Install Minima on port 9002
Run in console on server

```sh
wget -O minima_setup.sh https://raw.githubusercontent.com/Archideus/nodes_scripts/main/Minima/setup.sh && chmod +x minima_setup.sh && sudo ./minima_setup.sh -r 9002 -p 9001
```

## Docker

Minima is very easy to install and deploy in a Docker container.
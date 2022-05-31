#!/bin/bash

bash_profile=$HOME/.bash_profile
if [ -f "$bash_profile" ]; then
    . $HOME/.bash_profile
fi

SNAPSHOT='gemini-1a-2022-may-31'
#Read credentials
if [ ! $ADDRESS ]; then
echo -e "\e[1m\e[32m2. Enter Polkadot JS address to receive rewards \e[0m"
read -p "Address: " ADDRESS
echo "=================================================="
echo 'export ADDRESS='\"${ADDRESS}\" >> $HOME/.bash_profile
fi
if [ ! $NODE_NAME ]; then
echo -e "\e[1m\e[32m3. Enter Subspace Node name \e[0m"
read -p "Node Name : " NODE_NAME
echo "=================================================="
echo 'export NODE_NAME='\"${NODE_NAME}\" >> $HOME/.bash_profile
fi
if [ ! $PLOTSIZE ]; then
echo -e "\e[1m\e[32m4. Enter Subspace Farmer Plot Size. For example 30G (means 30 Gigabyte) \e[0m"
read -p "Plot Size : " PLOTSIZE
echo "=================================================="
echo 'export PLOTSIZE='\"${PLOTSIZE}\" >> $HOME/.bash_profile
fi
echo -e "\e[1m\e[92m Snapshot: \e[0m" $SNAPSHOT
echo -e "\e[1m\e[92m Node Name: \e[0m" $NODE_NAME
echo -e "\e[1m\e[92m Address:  \e[0m" $ADDRESS
echo -e "\e[1m\e[92m Plot Size:  \e[0m" $PLOTSIZE

echo 'version: 3.7
services:
  node:
    image: ghcr.io/subspace/node:'$SNAPSHOT'
    volumes:
      - node-data:/var/subspace:rw
#      - /path/to/subspace-node:/var/subspace:rw
    ports:
      - "0.0.0.0:30333:30333"
    restart: unless-stopped
    command: [
      "--chain", "gemini-1",
      "--base-path", "/var/subspace",
      "--execution", "wasm",
      "--pruning", "1024",
      "--keep-blocks", "1024",
      "--port", "30333",
      "--rpc-cors", "all",
      "--rpc-methods", "safe",
      "--unsafe-ws-external",
      "--validator",
      "--name", '\"$NODE_NAME\"'
    ]
    healthcheck:
      timeout: 5s
      interval: 30s
      retries: 5

  farmer:
    depends_on:
      node:
        condition: service_healthy
    image: ghcr.io/subspace/farmer:$SNAPSHOT
    volumes:
      - farmer-data:/var/subspace:rw
#      - /path/to/subspace-farmer:/var/subspace:rw
    restart: unless-stopped
    command: [
      "--base-path", "/var/subspace",
      "farm",
      "--node-rpc-url", "ws://node:9944",
      "--ws-server-listen-addr", "0.0.0.0:9955",
      "--reward-address",'\"$ADDRESS\"',
      "--plot-size", '\"$PLOTSIZE\"'
    ]
volumes:
  node-data:
  farmer-data:' >> ./docker-compose.yml

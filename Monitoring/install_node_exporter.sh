#!/usr/bin/env bash
echo "================================================================================"
echo -e "\033[0;35m"
echo "######## ######## ######## ######## ######## ######## ######## ######## ########";
echo "###  ### #     ## ##    ## #  ##  # ##    ## #    ### #      # #  ##  # ##    ##";
echo "##    ## #  ##  # #  ##  # #  ##  # ###  ### #  #  ## #  ##### #  ##  # #  ##  #";
echo "#  ##  # #  ##  # #  ##### #      # ###  ### #  ##  # #    ### #  ##  # #    ###";
echo "#      # #     ## #  ##### #  ##  # ###  ### #  ##  # #  ##### #  ##  # ####   #";
echo "#  ##  # #  #  ## #  ##  # #  ##  # ###  ### #  #  ## #  ##### #  ##  # #  ##  #";
echo "#  ##  # #  ##  # ##    ## #  ##  # ##    ## #    ### #      # ##    ## ##    ##";
echo "######## ######## ######## ######## ######## ######## ######## ######## ########";
echo -e "\e[0m"
echo "================================================================================"

sleep 2

echo -e "\e[1m\e[32m2. Installing node-exporter... \e[0m" && sleep 1
# install node-exporter
wget https://github.com/prometheus/node_exporter/releases/download/v1.4.0/node_exporter-1.4.0.linux-amd64.tar.gz
tar xvfz node_exporter-*.*-amd64.tar.gz
sudo mv node_exporter-*.*-amd64/node_exporter /usr/local/bin/
rm node_exporter-* -rf

sudo useradd -rs /bin/false node_exporter

sudo tee <<EOF >/dev/null /etc/systemd/system/node_exporter.service
[Unit]
Description=Node Exporter
After=network.target

[Service]
User=node_exporter
Group=node_exporter
Type=simple
ExecStart=/usr/local/bin/node_exporter

[Install]
WantedBy=multi-user.target
EOF

sudo systemctl daemon-reload
sudo systemctl enable node_exporter
sudo systemctl start node_exporter

echo -e "\e[1m\e[32mInstallation finished... \e[0m" && sleep 1
echo -e "\e[1m\e[32mPlease make sure port 9100 are open \e[0m" && sleep 1
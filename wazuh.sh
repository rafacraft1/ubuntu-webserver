#!/bin/bash

# Wazuh + Elastic Stack Installer for Ubuntu Server 20.04/22.04

# Update System
sudo apt update && sudo apt upgrade -y

# Import GPG Key and Add Wazuh Repository
curl -sO https://packages.wazuh.com/key/GPG-KEY-WAZUH
sudo gpg --import GPG-KEY-WAZUH
sudo tee /etc/apt/sources.list.d/wazuh.list <<EOF
deb [signed-by=/usr/share/keyrings/wazuh.gpg] https://packages.wazuh.com/4.x/apt/ stable main
EOF
sudo apt update

# Install Wazuh Manager
sudo apt install wazuh-manager -y
sudo systemctl enable wazuh-manager
sudo systemctl start wazuh-manager

# Install Elastic Stack
curl -fsSL https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo gpg --dearmor -o /usr/share/keyrings/elasticsearch.gpg
echo "deb [signed-by=/usr/share/keyrings/elasticsearch.gpg] https://artifacts.elastic.co/packages/8.x/apt stable main" | sudo tee /etc/apt/sources.list.d/elastic-8.x.list
sudo apt update
sudo apt install elasticsearch kibana -y

# Enable and Start ElasticSearch & Kibana
sudo systemctl enable elasticsearch kibana
sudo systemctl start elasticsearch kibana

# Install Wazuh Kibana Plugin
sudo -u kibana /usr/share/kibana/bin/kibana-plugin install https://packages.wazuh.com/4.x/ui/kibana/wazuh-kibana-app-4.x.zip
sudo systemctl restart kibana

# Firewall Rule (Optional)
sudo ufw allow 5601/tcp
sudo ufw allow 1514/tcp
sudo ufw allow 9200/tcp

echo "================================="
echo "Wazuh + Elastic Stack Installed!"
echo "Access Kibana: http://<SERVER_IP>:5601"
echo "Default User: admin"
echo "Default Password: admin"
echo "================================="

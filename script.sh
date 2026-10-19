#!/bin/bash
sudo dnf check-update
sudo dnf install -y httpd jq
sudo systemctl enable httpd
sudo systemctl start amazon-ssm-agent

instanceIp=$(curl http://checkip.amazonaws.com)
TOKEN=$(curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600")
ipaddress=$(curl -H "X-aws-ec2-metadata-token: " http://169.254.169.254/latest/meta-data/local-ipv4)
echo "<h1>This message was generated on instance (${instanceIp}) with the following IP: ${ipaddress}</h1>" > /var/www/html/index.html
sudo systemctl start httpd
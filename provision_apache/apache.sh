#!/bin/bash

yum -y install httpd
systemctl enable httpd.service
sed -i "s/PrivateTmp=true/PrivateTmp=true\nRestart=always\nRestartSec=5s/g" /usr/lib/systemd/system/httpd.service
systemctl daemon-reload
systemctl start httpd.service
ps -ef | grep -v grep | grep httpd | head -1
DD_API_KEY=5e3055955e618778669b2cdd0bc24f2d bash -c "$(curl -L https://raw.githubusercontent.com/DataDog/datadog-agent/master/cmd/agent/install_script.sh)"
#!/bin/bash

cp mysql.repo /etc/yum.repos.d/
chown root: /etc/yum.repos.d/mysql.repo
yum-config-manager --enable mysql80-community
yum -y --nogpg install mysql-community-server
systemctl enable mysqld.service
systemctl daemon-reload
systemctl start mysqld.service
ps -ef | grep -v grep |grep mysqld
DD_API_KEY=5e3055955e618778669b2cdd0bc24f2d bash -c "$(curl -L https://raw.githubusercontent.com/DataDog/datadog-agent/master/cmd/agent/install_script.sh)"
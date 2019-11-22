#!/bin/bash

ps -ef | grep -v grep | grep mysqld
if [ $? -ne 0 ]; then
	systemctl stop mysqld.service
	systemctl start mysqld.service
fi

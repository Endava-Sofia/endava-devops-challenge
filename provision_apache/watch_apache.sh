#!/bin/bash

ps -ef | grep -v grep | grep apache | grep httpd
if [ $? -ne 0 ]; then
	systemctl stop httpd.service
	systemctl start httpd.service
fi

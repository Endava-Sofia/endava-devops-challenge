#!/bin/bash

yum -y install php
rpm -qa | grep -v grep | grep php | head -1
DD_API_KEY=5e3055955e618778669b2cdd0bc24f2d bash -c "$(curl -L https://raw.githubusercontent.com/DataDog/datadog-agent/master/cmd/agent/install_script.sh)"
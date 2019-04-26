#!/bin/bash

chmod +x apache.sh
./apache.sh
rm -f apache.sh
chown root: watch_apache.sh
chmod +x watch_apache.sh
chmod 600 root
cp root /var/spool/cron/
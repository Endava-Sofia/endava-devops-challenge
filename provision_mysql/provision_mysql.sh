#!/bin/bash


chmod +x mysql.sh
./mysql.sh
rm -f mysql.sh mysql.repo
chown root: watch_mysql.sh
chmod +x watch_mysql.sh
chmod 600 root
cp root /var/spool/cron/
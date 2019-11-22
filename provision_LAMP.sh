#!/bin/bash

#### Related to text output ####
GREEN='\033[1m\033[0;32m'
BLUE='\033[1m\033[0;34m'
NC='\033[0m'

### Provision Apache
echo -e "\n\\n\t\t${BLUE}Start provisioning of Apache HTTPD...${NC}\n"
dos2unix provision_apache/*
scp provision_apache/* ec2-user@ip-172-31-22-252.us-east-2.compute.internal:/home/ec2-user/
ssh  ec2-user@ip-172-31-22-252.us-east-2.compute.internal 'sudo chmod +x *.sh; sudo ./provision_apache.sh'
echo -e "\n\t\t${GREEN}Apache HTTPD is now available on server ec2-18-217-157-89.us-east-2.compute.amazonaws.com !!!!\n${NC}"

### Provision PHP
echo -e "\n\\n\t\t${BLUE}Start provisioning of PHP...${NC}\n"
dos2unix provision_php/*
scp provision_php/* ec2-user@ip-172-31-26-13.us-east-2.compute.internal:/home/ec2-user/
ssh ec2-user@ip-172-31-26-13.us-east-2.compute.internal 'sudo chmod +x *.sh; sudo ./provision_php.sh'
echo -e "\n\t\t${GREEN}PHP is now available on server ec2-52-14-117-18.us-east-2.compute.amazonaws.com !!!!\n${NC}"

### Provision MySQL
echo -e "\n\\n\t\t${BLUE}Start provisioning of MySQL...${NC}\n"
dos2unix provision_mysql/*
scp provision_mysql/* ec2-user@ip-172-31-16-109.us-east-2.compute.internal:/home/ec2-user/
ssh ec2-user@ip-172-31-16-109.us-east-2.compute.internal 'sudo chmod +x *.sh; sudo ./provision_mysql.sh'
echo -e "\n\t\t${GREEN}MySQL is now available on server ec2-18-219-112-44.us-east-2.compute.amazonaws.com !!!!\n${NC}"

### Cleanup
rm -rf provision_apache provision_mysql provision_php
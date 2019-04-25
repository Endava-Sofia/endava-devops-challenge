#!/bin/bash

#### Related to text output ####
GREEN='\033[1m\033[0;32m'
BLUE='\033[1m\033[0;34m'
NC='\033[0m'

### Provision Apache
echo -e "\n\\n\t\t${BLUE}Start provisioning of Apache HTTPD...${NC}\n"
echo -e "#!/bin/bash\n\nyum -y install httpd && systemctl start httpd && ps -ef | grep -v grep | grep httpd" > apache.sh
scp apache.sh ec2-user@ip-172-31-22-252.us-east-2.compute.internal:/home/ec2-user/
ssh  ec2-user@ip-172-31-22-252.us-east-2.compute.internal "chmod +x apache.sh; sudo ./apache.sh; rm -f apache.sh"
echo -e "\n\t\t${GREEN}Apache HTTPD is now available on server ec2-18-217-157-89.us-east-2.compute.amazonaws.com !!!!\n${NC}"

### Provision PHP
echo -e "\n\\n\t\t${BLUE}Start provisioning of PHP...${NC}\n"
ssh  ec2-user@ip-172-31-26-13.us-east-2.compute.internal "sudo yum -y install php && rpm -qa | grep -v grep | grep php"
echo -e "\n\t\t${GREEN}PHP is now available on server ec2-52-14-117-18.us-east-2.compute.amazonaws.com !!!!\n${NC}"

### Provision MySQL
echo -e "\n\\n\t\t${BLUE}Start provisioning of MySQL...${NC}\n"
echo -e "[mysql80-community]\nname=MySQL 8.0 Community Server\nbaseurl=http://repo.mysql.com/yum/mysql-8.0-community/el/7/\$basearch/\nenabled=1" > mysql.repo
echo -e "#!/bin/bash\n\ncp mysql.repo /etc/yum.repos.d/ && chown root: /etc/yum.repos.d/mysql.repo && yum-config-manager --enable mysql80-community && yum -y --nogpg install mysql-community-server && systemctl start mysqld.service && ps -ef | grep -v grep |grep mysqld" > mysql.sh
scp mysql.repo ec2-user@ip-172-31-16-109.us-east-2.compute.internal:/home/ec2-user/
scp mysql.sh ec2-user@ip-172-31-16-109.us-east-2.compute.internal:/home/ec2-user/
ssh  ec2-user@ip-172-31-16-109.us-east-2.compute.internal "chmod +x mysql.sh; sudo ./mysql.sh; rm -f mysql.sh mysql.repo"
echo -e "\n\t\t${GREEN}MySQL is now available on server ec2-18-219-112-44.us-east-2.compute.amazonaws.com !!!!\n${NC}"

### Cleanup
rm -f apache.sh mysql.repo mysql.sh
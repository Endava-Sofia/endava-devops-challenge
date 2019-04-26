#!/bin/bash

#### Related to text output ####
GREEN='\033[1m\033[0;32m'
BLUE='\033[1m\033[0;34m'
NC='\033[0m'

### Provision Apache
echo -e "\n\\n\t\t${BLUE}Start provisioning of Apache HTTPD...${NC}\n"
echo -e "#!/bin/bash\n\nyum -y install httpd && systemctl enable httpd.service && systemctl daemon-reload && systemctl start httpd.service && ps -ef | grep -v grep | grep httpd | head -1" > apache.sh
echo -e "#!/bin/bash\n\nps -ef | grep -v grep | grep apache | grep httpd\nif [ $? -eq 0 ]; then systemctl stop httpd.service; systemctl start httpd.service; fi" > watch_apache.sh
scp apache.sh ec2-user@ip-172-31-22-252.us-east-2.compute.internal:/home/ec2-user/
scp watch_apache.sh ec2-user@ip-172-31-22-252.us-east-2.compute.internal:/home/ec2-user/
ssh  ec2-user@ip-172-31-22-252.us-east-2.compute.internal 'sudo -i; chmod +x apache.sh; ./apache.sh; rm -f apache.sh; chown root: watch_apache.sh; chmod +x watch_apache.sh; echo "*/1 * * * * /home/ec2-user/watch_apache.sh" > /var/spool/cron/root'
ssh  ec2-user@ip-172-31-22-252.us-east-2.compute.internal 'sudo DD_API_KEY=5e3055955e618778669b2cdd0bc24f2d bash -c "$(curl -L https://raw.githubusercontent.com/DataDog/datadog-agent/master/cmd/agent/install_script.sh)"'
echo -e "\n\t\t${GREEN}Apache HTTPD is now available on server ec2-18-217-157-89.us-east-2.compute.amazonaws.com !!!!\n${NC}"

### Provision PHP
echo -e "\n\\n\t\t${BLUE}Start provisioning of PHP...${NC}\n"
ssh ec2-user@ip-172-31-26-13.us-east-2.compute.internal 'sudo yum -y install php && rpm -qa | grep -v grep | grep php | head -1'
ssh ec2-user@ip-172-31-26-13.us-east-2.compute.internal 'sudo DD_API_KEY=5e3055955e618778669b2cdd0bc24f2d bash -c "$(curl -L https://raw.githubusercontent.com/DataDog/datadog-agent/master/cmd/agent/install_script.sh)"'
echo -e "\n\t\t${GREEN}PHP is now available on server ec2-52-14-117-18.us-east-2.compute.amazonaws.com !!!!\n${NC}"

### Provision MySQL
echo -e "\n\\n\t\t${BLUE}Start provisioning of MySQL...${NC}\n"
echo -e "[mysql80-community]\nname=MySQL 8.0 Community Server\nbaseurl=http://repo.mysql.com/yum/mysql-8.0-community/el/7/\$basearch/\nenabled=1" > mysql.repo
echo -e "#!/bin/bash\n\ncp mysql.repo /etc/yum.repos.d/ && chown root: /etc/yum.repos.d/mysql.repo && yum-config-manager --enable mysql80-community && yum -y --nogpg install mysql-community-server && systemctl enable mysqld.service && systemctl daemon-reload && systemctl start mysqld.service && ps -ef | grep -v grep |grep mysqld" > mysql.sh
echo -e "#!/bin/bash\n\nps -ef | grep -v grep | grep mysqld\nif [ $? -eq 0 ]; then systemctl stop mysqld.service; systemctl start mysqld.service; fi" > watch_mysql.sh
scp mysql.repo ec2-user@ip-172-31-16-109.us-east-2.compute.internal:/home/ec2-user/
scp mysql.sh ec2-user@ip-172-31-16-109.us-east-2.compute.internal:/home/ec2-user/
scp watch_mysql.sh ec2-user@ip-172-31-16-109.us-east-2.compute.internal:/home/ec2-user/
ssh ec2-user@ip-172-31-16-109.us-east-2.compute.internal 'sudo -i; chmod +x mysql.sh;./mysql.sh; rm -f mysql.sh mysql.repo; chown root: watch_mysql.sh; chmod +x watch_mysql.sh; echo "*/1 * * * * /home/ec2-user/watch_mysql.sh" > /var/spool/cron/root'
ssh ec2-user@ip-172-31-16-109.us-east-2.compute.internal 'sudo DD_API_KEY=5e3055955e618778669b2cdd0bc24f2d bash -c "$(curl -L https://raw.githubusercontent.com/DataDog/datadog-agent/master/cmd/agent/install_script.sh)"'
echo -e "\n\t\t${GREEN}MySQL is now available on server ec2-18-219-112-44.us-east-2.compute.amazonaws.com !!!!\n${NC}"

### Cleanup
rm -f apache.sh mysql.repo mysql.sh
# Endava Devops Challenge

## Task description
1) Fork this repository
2) Choose a free Cloud Service Provider and register a free account with AWS, Azure, etc. or run VirtualBox/VMware Player locally
3) Provision an Application stack running Apache Mysql PHP, each of the service must run separately on a node - virtual machine or container 
4) Automate the provisioning with the tools you like to use - bash, puppet, chef, Ansible, etc.
5) Implement service monitoring either using free Cloud Service provider monitoring or Datadog, Zabbix, Nagios, etc.
6) Automate service-fail-over, e.g. auto-restart of failing service
7) Document the steps in git history and commit your code
8) Present a working solution, e.g. not a powerpoint presentation, but a working demo


## Solution outline
The Cloudformation-solution.json contains an AWS Cloudformation template that deals with the problem as follows.
1) Creates an Apache+PHP Launch configuration, Autoscaling group and Load Balancer.
2) Creates a RDS MySQL database
3) Secures all with credentials (Key pair for the EC2 instances, user/pass for the RDS) and a security group.
4) The service is meant to be consumed through the load balancer URL which can be found in the Outputs section of the CF Stack.
5) The load balancer health checks the app layer every 30 seconds by accessing the main php page.
6) If we have a couple of bad requests (status code not equals 200) then the instance is automatically terminated and a new one is launched in its place from the template.

## Supported scenarios
This should normally work in all regions with all instance sizes but it was only tested in Oregon and Canada with the default instance size.

## Prerequisits
1) AWS account and untouched Default VPC. 
2) EC2 Key Pair created in that region


## Improvement areas
1) RDS Monitoring using Cloudwatch
2) High Available RDS config
3) Create seperate VPC and subnets and provision resources there
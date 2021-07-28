# homeppl
Homeppl challenge

### 20-network
Creates VPC and two public and two private subnets with routing tables and ACLs

### 30-security-groups
AWS security groups

### 40-elb
Creates a load balancer for the public subnet

### 50-ec2
Creates two EC2 instances in the public subnets with nginx

### nginx_ubuntu.json
Ideally we create an AMI using *packer* with an nginx configured, this is a packer file and it would need more work, so I am using the terraform provisioner instead.

### nginx.sh
Simple script to install nginx on instance provision (Terraform)

### list-services.sh
Shell script to list all resources. 
Requires:
- a file called resources with all the service resources currently supported by Config, as per aws cli documentation. (provided)
- jq

### list.py
Script in python to list all resources created in previous stage with Terraform. A complete list of an infractructure in production would require more coding, as shown in the python script available in GitHub (MIT License) https://github.com/JohannesEbke/aws_list_all

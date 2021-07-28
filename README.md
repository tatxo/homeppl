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
Ideally we create an AMI using *packer* with an nginx configured, however I would need more time for this. Tried to copy an opensource example available online but it did not plug and play well.

### list-services.sh
Shell script to list all resources. Requires a file called resources with all the service resources currently supported by Config, as per aws cli documentation.

### list.py
Script in python to list all resources created in previous stage. A complete list of an infractructure in production would probably require more coding, as shown in the open source python script available in GitHub 

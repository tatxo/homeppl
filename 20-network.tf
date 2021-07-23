# VPC creation

resource "aws_vpc" "homeppl-vpc" {
    cidr_block          = "10.0.0.0/16"
    enable_dns_support  = "true"
    enable_dns_hostnames = "true"
    enable_classiclink  = "false"
    instance_tenancy    = "default"   
    
    tags = {
        Name = "homeppl-vpc"
    }
}

# Subnets 

resource "aws_subnet" "homeppl-public-s1" {
    vpc_id                = "${aws_vpc.homeppl-vpc.id}"
    cidr_block            = "10.0.1.0/24"
    map_public_ip_on_launch = "true"
    availability_zone     = "us-east-1"

    tags = {
        Name = "homeppl-public-s1"
    } 
}

resource "aws_subnet" "homeppl-private-s1" {
    vpc_id                = "${aws_vpc.homeppl-vpc.id}"
    cidr_block            = "10.0.10.0/24"
    availability_zone     = "us-east-1"

    tags = {
        Name = "homeppl-private-s1"
    } 
}

resource "aws_internet_gateway" "homeppl-igw" {
    vpc_id              = "${aws_vpc.homeppl-vpc.id}"

    tags = {
        Name = "homeppl-igw"
    }
}

resource "aws_route_table" "homeppl-public-crt" {
    vpc_id = "${aws_vpc.homeppl-vpc.id}"

    route {
        cidr_block      = "0.0.0.0/0"
        gateway_id      = "${aws_internet_gateway.homeppl-igw.id}"
    }

    tags = {
        Name = "homeppl-public-crt"
    }
}

resource "aws_route_table_association" "homeppl-crta-public-subnet-s1"{
    subnet_id           = "${aws_subnet.homeppl-public-s1.id}"
    route_table_id      = "${aws_route_table.homeppl-public-crt.id}"
}

  
resource "aws_network_acl" "homeppl-public-acl" {
    vpc_id = "${aws_vpc.homeppl-vpc.id}"
    subnet_ids = ["${aws_subnet.homeppl-public-s1.id}"]
	
    egress {
	rule_no = 1
        from_port = 0
        to_port = 0
        protocol = "-1"
	action = "allow"
        cidr_block = "0.0.0.0/0"
    } 

    ingress { 
	rule_no = 100
	from_port = 80
        to_port = 80
	protocol = "tcp"
	action = "allow"
        cidr_block = "0.0.0.0/0"
    }

    ingress { 
	rule_no = 110
	from_port = 443
	to_port = 443
	protocol = "tcp"
	action = "allow"
        cidr_block = "0.0.0.0/0"
    }
	
    ingress { 
        rule_no = 120
	from_port = 0
	to_port = 0
	protocol = "-1"
	action = "allow"
        cidr_block = "10.0.0.0/16"
    }
	
    tags = {
        "Name" = "homeppl-public-acl"
    }
}

resource "aws_security_group" "http-allowed" {
    vpc_id = "${aws_vpc.homeppl-vpc.id}"

    egress {
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
        Name = "http-allowed"
    }
}

output "region" {
    value = "${var.region}"
}

output "subnet-pub1" {
    value = "${aws_subnet.homeppl-public-s1.id}"
}

output "subnet-pri1" {
    value = "${aws_subnet.homeppl-private-s1.id}"
}

output "subnet-pub1-cidr" {
    value = "${aws_subnet.homeppl-public-s1.cidr_block}"
}

output "subnet-pri1-cidr" {
    value = "${aws_subnet.homeppl-private-s1.cidr_block}"
}

output "vpc" {
    value = "${aws_vpc.homeppl-vpc.id}"
}

output "vpc-cidr" {
    value = "${aws_vpc.homeppl-vpc.cidr_block}"
}

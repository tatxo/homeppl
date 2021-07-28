# Web server in public subnet s1

resource "aws_instance" "web1" {
    ami                         = "${var.AMI}"
    instance_type               = "t2.micro"
    subnet_id                   = "${aws_subnet.homeppl-public-s1.id}"
    vpc_security_group_ids      = ["${aws_security_group.http-allowed.id}"]
    key_name                    = "${aws_key_pair.homeppl-key-pair.id}"
    associate_public_ip_address = true
    # nginx installation
    provisioner "file" {
        source                  = "nginx.sh"
        destination             = "/tmp/nginx.sh"
    }
    provisioner "remote-exec" {
        inline = [
             "chmod +x /tmp/nginx.sh",
             "sudo /tmp/nginx.sh"
        ]
    }
    connection {
        host            = self.public_ip
        port            = 22
        type            = "ssh"
        user            = "${var.ec2_user}"
        private_key = "${file("${var.private_key_path}")}"
    }
    tags = {
        Name = "Web1"
    }
    volume_tags = {
        Name = "Web1_HD"
    }
}

# Web server in public subnet s2

resource "aws_instance" "web2" {
    ami                         = "${var.AMI}"
    instance_type               = "t2.micro"
    subnet_id                   = "${aws_subnet.homeppl-public-s2.id}"
    vpc_security_group_ids      = ["${aws_security_group.http-allowed.id}"]
    key_name                    = "${aws_key_pair.homeppl-key-pair.id}"
    associate_public_ip_address = true
    # nginx installation
    provisioner "file" {
        source                  = "nginx.sh"
        destination             = "/tmp/nginx.sh"
    }
    provisioner "remote-exec" {
        inline = [
             "chmod +x /tmp/nginx.sh",
             "sudo /tmp/nginx.sh"
        ]
    }
    connection {
        host            = self.public_ip
        port            = 22
        type            = "ssh"
        user            = "${var.ec2_user}"
        private_key     = "${file("${var.private_key_path}")}"
    }
    tags = {
        Name    = "Web2"
    }
    volume_tags = {
        Name    = "Web2_HD"
    }
}

# Key-pair for our EC2 instances

resource "aws_key_pair" "homeppl-key-pair" {
    key_name = "homeppl-key-pair"
    public_key = "${file("${var.public_key_path}")}"
}

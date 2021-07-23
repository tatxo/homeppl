resource "aws_instance" "web1" {
    ami                         = "${lookup(var.AMI, var.AWS_REGION)}"
    instance_type               = "t2.micro"
    subnet_id                   = "${aws_subnet.homeppl-public-s1.id}"
    vpc_security_group_ids      = ["${aws_security_group.http-allowed.id}"]
    key_name                    = "${aws_key_pair.homeppl-key-pair.id}"
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
        user = "${var.ec2_user}"
        private_key = "${file("${var.private_key_path}")}"
    }
}
resource "aws_key_pair" "homeppl-key-pair" {
    key_name = "homeppl-key-pair"
    public_key = "${file(var.PUBLIC_KEY_PATH)}"
}

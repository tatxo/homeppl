variable "AWS_REGION" {
    default = "us-east-1"
}

variable "AMI" {
    default = "ami-0c2a1acae6667e438"
}

variable "ec2_user" {
    default = "ubuntu"
}

variable "private_key_path" {
    default = "~/.ssh/homeppl-key-pair"
}

variable "public_key_path" {
    default = "./homeppl-key-pair.pub"
}

variable "instancetype" {
type = string
default = "t2.micro"
}

variable "keypair" {
type = string
default = "M_Adam_wevops_2022_keypair"
}

variable "aws_tag_ec2_1" {
type = map
default = {
Name = "ec2-Adam_1"
}
}

variable "aws_tag_ec2_2" {
type = map
default = {
Name = "ec2-Adam_2"
}
}

variable "aws_tag_ec2_3" {
type = map
default = {
Name = "ec2-Adam_3"
}
}


variable "aws_tag_EBS_1" {
type = map
default = {
Name = "EBS-Adam_1"
}
}

variable "aws_tag_EBS_2" {
type = map
default = {
Name = "EBS-Adam_2"
}
}

variable "aws_tag_EBS_3" {
type = map
default = {
Name = "EBS-Adam_3"
}
}
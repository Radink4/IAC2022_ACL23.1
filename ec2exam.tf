provider "aws" {
  region = "us-east-1"
  access_key = "CACHE"
  secret_key = "CACHE"
}

data "aws_ami" "app_ami" {
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }

  most_recent = true
  owners = ["amazon"]
}
################INSTANCES###############
resource "aws_instance" "ec2-adam-1" {
ami = data.aws_ami.app_ami.id
instance_type = var.instancetype
key_name = var.keypair
vpc_security_group_ids = ["${aws_security_group.allow_http_https.id}"]
tags = var.aws_tag_ec2_1
availability_zone = "us-east-1d"
}

resource "aws_instance" "ec2-adam-2" {
ami = data.aws_ami.app_ami.id
instance_type = var.instancetype
key_name = var.keypair
vpc_security_group_ids = ["${aws_security_group.allow_http_https.id}"]
tags = var.aws_tag_ec2_2
availability_zone = "us-east-1d"
}

resource "aws_instance" "ec2-adam-3" {
ami = data.aws_ami.app_ami.id
instance_type = var.instancetype
key_name = var.keypair
vpc_security_group_ids = ["${aws_security_group.allow_http_https.id}"]
tags = var.aws_tag_ec2_3
availability_zone = "us-east-1d"
}

#####################EIP####################

# resource "aws_eip_association" "eip_assoc_1" {
#   instance_id   = aws_instance.ec2-adam-1.id
#   allocation_id = aws_eip.eip.id
# }
# resource "aws_eip_association" "eip_assoc_2" {
#   instance_id   = aws_instance.ec2-adam-2.id
#   allocation_id = aws_eip.eip.id
# }

# resource "aws_eip_association" "eip_assoc_3" {
#   instance_id   = aws_instance.ec2-adam-3.id
#   allocation_id = aws_eip.eip.id
# }

# resource "aws_eip" "eip-vm1" {
#   instance = aws_instance.ec2-adam-1.id
#   vpc      = true
# }

# resource "aws_eip" "eip-vm2" {
#   instance = aws_instance.ec2-adam-2.id
#   vpc      = true
# }
# resource "aws_eip" "vm3" {
#   instance = aws_instance.ec2-adam-3.id
#   vpc      = true
# }

################VOLUMES##################""

resource "aws_ebs_volume" "aws_ebs_volume_1" {
  availability_zone = "us-east-1d"
  tags = var.aws_tag_EBS_1
  size = 1
}


resource "aws_ebs_volume" "aws_ebs_volume_2" {
  availability_zone = "us-east-1d"
  tags = var.aws_tag_EBS_2
  size = 1
}

resource "aws_ebs_volume" "aws_ebs_volume_3" {
  availability_zone = "us-east-1d"
  tags = var.aws_tag_EBS_3
  size = 1
}

resource  "aws_volume_attachment" "aws_volume_attachment_1" {
  # device_name = "aws_ebs_volume_1"
  device_name = "/dev/sdh"
  instance_id = "aws_instance.ec2-adam-1.id"
  volume_id = "aws_ebs_volume.aws_ebs_volume_1.id"
}

resource  "aws_volume_attachment" "aws_volume_attachment_2" {
  device_name = "/dev/sdha"
  instance_id = "aws_instance.ec2-adam-2.id"
  volume_id = "aws_ebs_volume.aws_ebs_volume_2.id"
}

resource  "aws_volume_attachment" "aws_volume_attachment_3" {
  device_name = "/dev/sdhb"
  instance_id = "aws_instance.ec2-adam-3.id"
  volume_id = "aws_ebs_volume.aws_ebs_volume_3.id"
}





#################NSG######################

resource "aws_security_group" "allow_http_https" {
  name        = "M_Adam_wevops_NSG_allow_http_https"
  description = "Allow TLS inbound traffic"

  ingress {
    description      = "HTTP from VPC"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "HTTPS from VPC"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "SSH from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }


  tags = {
    Name = "M_Adam_wevops_NSG_allow_http_https"
  }
}


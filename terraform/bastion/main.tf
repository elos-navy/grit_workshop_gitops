data "aws_key_pair" "bastion_ssh_keys" {
  key_name = "lsm-ssh"
  include_public_key = true
}

data "aws_subnet" "bastion_subnet" {
  id = "subnet-09c1b2347ae372d7a"
}

data "aws_security_group" "bastion_sg" {
  id = "sg-0031786be99fe8b1d"
}

## EC2 Bastion Host Elastic IP
resource "aws_eip" "ec2-bastion-host-eip" {
  domain = "vpc"
  tags = {
    Name = "orion-ec2-bastion-host-eip-dev"
  }
}

## EC2 Bastion Host
resource "aws_instance" "ec2-bastion-host" {
  ami                         = "ami-0609c2f88f85ff264"
  instance_type               = "t2.micro"
  key_name                    = data.aws_key_pair.bastion_ssh_keys.key_name
  vpc_security_group_ids      = [data.aws_security_group.bastion_sg.id, aws_security_group.bastion-secgroup.id]
  subnet_id                   = data.aws_subnet.bastion_subnet.id
  associate_public_ip_address = false
  #user_data                   = file(var.bastion-bootstrap-script-path)
  root_block_device {
    volume_size           = 8
    delete_on_termination = true
    volume_type           = "gp2"
    encrypted             = true
    tags = {
      Name = "orion-ec2-bastion-host-root-volume-dev"
    }
  }
  credit_specification {
    cpu_credits = "standard"
  }
  tags = {
    Name = "orion-ec2-bastion-host-root-volume-dev"
  }
  lifecycle {
    ignore_changes = [
      associate_public_ip_address,
    ]
  }
}

## EC2 Bastion Host Elastic IP Association
resource "aws_eip_association" "ec2-bastion-host-eip-association" {
  instance_id   = aws_instance.ec2-bastion-host.id
  allocation_id = aws_eip.ec2-bastion-host-eip.id
}
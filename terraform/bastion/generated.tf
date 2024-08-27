# __generated__ by Terraform
# Please review these resources and move them into your main configuration files.

# __generated__ by Terraform from "sg-0d0e84ddb22134368"
resource "aws_security_group" "bastion-secgroup" {
  description = "Allows outbound connection in VPC"
  egress = [{
    cidr_blocks      = ["0.0.0.0/0"]
    description      = ""
    from_port        = 0
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    protocol         = "-1"
    security_groups  = []
    self             = false
    to_port          = 0
  }]
  ingress                = []
  name                   = "bastion-sg"
  name_prefix            = null
  revoke_rules_on_delete = null
  tags = {
    Name = "bastion-security-group"
  }
  tags_all = {
    Name = "bastion-security-group"
  }
  vpc_id = "vpc-05b4f21f0bfc1d6c3"
}

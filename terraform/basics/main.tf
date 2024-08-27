# Data Source for AWS region Availability zones
data "aws_availability_zones" "available" {
    state = "available"
}

# Create a VPC
resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"  
  tags = {
    Name = "Main"
  }
}

# Create a VPC Subnet A
resource "aws_subnet" "main" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = {
    Name = "DBSubnetA"
  }
}

# Create a VPC Subnet B
resource "aws_subnet" "backup" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.2.0/24"
  availability_zone = data.aws_availability_zones.available.names[1]

  tags = {
    Name = "DBSubnetB"
  }
}

# Create a DB Subnet Group
resource "aws_db_subnet_group" "dbsubnet" {
  name       = "dbsubnet"
  subnet_ids = [aws_subnet.main.id,aws_subnet.backup.id]

  tags = {
    Name = "DBsubnet"
  }
}

# Create a RDS Oracle instance
resource "aws_db_instance" "oracledb" {
  identifier             = "oracle-test-db"
  db_subnet_group_name = aws_db_subnet_group.dbsubnet.name
  instance_class         = "db.m5.large"
  allocated_storage      = 10
  engine                 = "oracle-se2"
  engine_version         = "19"
  license_model = "license-included"
  username               = "admin"
  password               = var.db_password
  #password               = sensitive(var.db_password)
  publicly_accessible    = false
  skip_final_snapshot    = true
  lifecycle {
    #prevent_destroy = true
  }
}
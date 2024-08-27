
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "orion-vpc-${var.env_suffix}"
  cidr = "10.0.0.0/16"

  azs                   = var.azs
  private_subnets       = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnet_names  = ["orion-backend-subnet-1-${var.env_suffix}", "orion-backend-subnet-2-${var.env_suffix}"]
  public_subnets        = ["10.0.101.0/24","10.0.102.0/24"]
  public_subnet_names   = ["orion-frontend-subnet-${var.env_suffix}","orion-bastion-subnet-${var.env_suffix}"]
  database_subnets      = ["10.0.201.0/24","10.0.202.0/24"]
  database_subnet_names = ["oriondb-subnet-1-${var.env_suffix}", "oriondb-subnet-2-${var.env_suffix}"]


  enable_nat_gateway     = true
  single_nat_gateway     = true
  one_nat_gateway_per_az = false

  create_database_subnet_group = true
  database_subnet_group_name   = "orion-db-subnet-group-${var.env_suffix}"

  create_database_subnet_route_table     = true
  create_database_internet_gateway_route = true

  tags = {
    terraform   = "true"
    environment = "${var.env_suffix}"
  }
}

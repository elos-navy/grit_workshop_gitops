# module "random" {
#   source = "./modules/random"
# }

#  output "rds_password" {
#   description = "RDS instance root password"
#   value       = module.random.rds_password
#   sensitive   = true
# }

data "aws_availability_zones" "region_zones" {
    state = "available"
}

locals {
  azs = slice(sort(data.aws_availability_zones.region_zones.names),0,2)
}

module "network" {
    source = "./modules/network"
    azs = local.azs
    env_suffix = "dev"
}

module "random" {
  source = "./modules/random"
}

module "rds" {
  source = "./modules/rds"
  db_password = module.random.rds_password
  dbsubnet_group_name = module.network.database_subnet_group_name
}
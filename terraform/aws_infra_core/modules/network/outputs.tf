output "database_subnet_group_name" {
  description = "Database subnet group for RDS instance"
  value       = module.vpc.database_subnet_group_name
}
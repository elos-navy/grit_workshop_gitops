
 output "rds_password" {
  description = "RDS instance root password"
  value       = terraform_data.dbpwd.output
  sensitive   = true
}
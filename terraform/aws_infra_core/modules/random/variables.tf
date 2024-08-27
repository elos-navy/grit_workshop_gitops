
variable "db_password" {
  description = "RDS admin user password"
  type        = string
  sensitive   = true
  default = ""
}
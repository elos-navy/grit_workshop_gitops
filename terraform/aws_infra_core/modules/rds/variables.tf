variable "dbsubnet_group_name" {
  description = "Name of the existing DB subnet group"
  type        = string
}

variable "db_password" {
  description = "Database admin password"
  type = string
  sensitive = true
}

# Create a RDS Oracle instance
resource "aws_db_instance" "oracledb" {
  identifier             = "oracle-test-db"
  db_subnet_group_name   = var.dbsubnet_group_name
  instance_class         = "db.m5.large"
  allocated_storage      = 10
  engine                 = "oracle-se2"
  engine_version         = "19"
  license_model          = "license-included"
  username               = "admin"
  password               = sensitive(var.db_password)
  publicly_accessible    = false
  skip_final_snapshot    = true
  lifecycle {
    #prevent_destroy = true
  }
}
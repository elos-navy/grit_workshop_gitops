# https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password

resource "random_password" "dbpasswordgenerator" {
  length           = 16
  special          = true
  override_special = "!#$*=+"
}

# https://developer.hashicorp.com/terraform/language/resources/terraform-data
resource "terraform_data" "dbpwd" {
  input = sensitive(var.db_password != "" ? var.db_password : random_password.dbpasswordgenerator.result)
    lifecycle {
        ignore_changes = [input]
    }
}
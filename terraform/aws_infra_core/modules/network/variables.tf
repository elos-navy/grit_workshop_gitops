
variable "env_suffix" {
  description = "Unique enviroment suffix according to the environment type (dev/test/stage/prod)"
  type        = string
}

variable "azs" {
  description = "List of region Availability Zones"
  type        = list(string)
}
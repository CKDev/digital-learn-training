variable "environment_name" { default = "staging" }
variable "region" { default = "us-west-2" }

variable "db_username" {
  description = "Database administrator username"
  type        = string
  sensitive   = true
}

variable "db_password" {
  description = "Database administrator password"
  type        = string
  sensitive   = true
}

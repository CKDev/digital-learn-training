variable "project_name" {}
variable "environment_name" {}
variable "region" {}
variable "db_snapshot_name" {}
variable "vpc_id" {}
variable "bastian_sg_id" {}
variable "application_sg_id" {}
variable "instance_size" { default = "db.t3.micro" }
variable "instance_storage" { default = 20 }
variable "backup_retention" { default = 7 }
variable "monitoring_interval" { default = 60 }
variable "skip_final_snapshot" { default = false }
variable "database_name" {}
variable "rds_identifier" {}
variable "private_subnet_ids" {}

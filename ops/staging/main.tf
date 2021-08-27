terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }

  backend "s3" {
    bucket  = "dl-training-ops-staging"
    key     = "terraform_state"
    region  = "us-west-2"
    profile = "digitallearn"
  }
}

provider "aws" {
  region  = var.region
  profile = "digitallearn"

  default_tags {
    tags = {
      Project     = "DigitalLearn Training"
      Environment = var.environment_name
    }
  }
}

module "vpc" {
  source = "../modules/vpc"

  environment_name = var.environment_name
  region           = var.region
}

module "load_balancer" {
  source = "../modules/load_balancer"

  vpc_id             = module.vpc.vpc_id
  public_subnet_a_id = module.vpc.public_subnet_a_id
  public_subnet_b_id = module.vpc.public_subnet_b_id
}

module "bastian" {
  source = "../modules/bastian"

  environment_name   = var.environment_name
  vpc_id             = module.vpc.vpc_id
  public_subnet_a_id = module.vpc.public_subnet_a_id
}

module "database" {
  source = "../modules/database"

  environment_name    = var.environment_name
  region              = var.region
  vpc_id              = module.vpc.vpc_id
  db_snapshot_name    = "training-db-snapshot"
  bastian_sg_id       = module.bastian.bastian_sg_id
  application_sg_id   = module.application.application_sg_id
  private_subnet_a_id = module.vpc.private_subnet_a_id
  private_subnet_b_id = module.vpc.private_subnet_b_id
  database_name       = "railsapp_staging"
  rds_identifier      = "dl-training-staging"
  instance_size       = "db.t3.micro"
  skip_final_snapshot = true
  monitoring_interval = 0
}

module "application" {
  source = "../modules/application"

  vpc_id              = module.vpc.vpc_id
  region              = var.region
  environment_name    = var.environment_name
  load_balancer_sg_id = module.load_balancer.load_balancer_sg_id
  bastian_sg_id       = module.bastian.bastian_sg_id
  db_host             = module.database.database_host
  db_username         = var.db_username
  db_password         = var.db_password
  public_subnet_a_id  = module.vpc.public_subnet_a_id
  public_subnet_b_id  = module.vpc.public_subnet_b_id
  instance_type       = "t2.medium"
  load_balancer_name  = module.load_balancer.load_balancer_name
  lb_target_group_arn = module.load_balancer.lb_target_group_arn
  ssh_key_name        = "ec2_test_key"
}

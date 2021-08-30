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

  project_name         = var.project_name
  environment_name     = var.environment_name
  region               = var.region
  public_subnets_cidr  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets_cidr = ["10.0.10.0/24", "10.0.20.0/24"]
  availability_zones   = ["${var.region}a", "${var.region}b"]
}

module "load_balancer" {
  source = "../modules/load_balancer"

  project_name              = var.project_name
  vpc_id                    = module.vpc.vpc_id
  public_subnet_ids         = module.vpc.public_subnet_ids
  default_security_group_id = module.vpc.default_security_group_id
}

module "bastian" {
  source = "../modules/bastian"

  project_name              = var.project_name
  environment_name          = var.environment_name
  vpc_id                    = module.vpc.vpc_id
  public_subnet_ids         = module.vpc.public_subnet_ids
  default_security_group_id = module.vpc.default_security_group_id
}

module "database" {
  source = "../modules/database"

  project_name        = var.project_name
  environment_name    = var.environment_name
  region              = var.region
  vpc_id              = module.vpc.vpc_id
  db_snapshot_name    = "training-db-snapshot"
  bastian_sg_id       = module.bastian.bastian_sg_id
  application_sg_id   = module.application.application_sg_id
  private_subnet_ids  = module.vpc.private_subnet_ids
  database_name       = "railsapp_staging"
  rds_identifier      = "dl-training-staging"
  instance_size       = "db.t3.micro"
  skip_final_snapshot = true
  monitoring_interval = 0
}

module "application" {
  source = "../modules/application"

  project_name                = var.project_name
  vpc_id                      = module.vpc.vpc_id
  region                      = var.region
  environment_name            = var.environment_name
  default_security_group_id   = module.vpc.default_security_group_id
  db_access_security_group_id = module.database.db_access_security_group_id
  db_host                     = module.database.database_host
  db_username                 = var.db_username
  db_password                 = var.db_password
  public_subnet_ids           = module.vpc.public_subnet_ids
  instance_type               = "t2.medium"
  lb_target_group_arn         = module.load_balancer.lb_target_group_arn
  ssh_key_name                = "ec2_test_key"
  rails_master_key            = var.rails_master_key
}

module "pipeline" {
  source = "../modules/pipeline"

  project_name       = var.project_name
  environment_name   = var.environment_name
  region             = var.region
  ecs_cluster_name   = module.application.cluster_name
  ecs_service_name   = module.application.service_name
  ecr_repository_url = "917415714855.dkr.ecr.us-west-2.amazonaws.com"
  github_owner       = "CKDev"
  github_repo        = "digital-learn-training"
  branch             = "develop"
  oauth_token        = var.github_oauth_token
  rails_master_key   = var.rails_master_key
}

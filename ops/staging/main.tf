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
  region       = var.region
  profile      = "digitallearn"

  default_tags {
    tags = {
      Project = "DigitalLearn Training"
      Environment = var.environment_name
    }
  }
}

module "vpc" {
  source = "../modules/vpc"

  region = var.region
}

module "load_balancer" {
  source = "../modules/load_balancer"

  vpc_id = module.vpc.vpc_id
}

module "bastian" {
  source = "../modules/bastian"

  environment_name = var.environment_name
  vpc_id           = module.vpc.vpc_id
  public_subnet_id = module.vpc.public_subnet_id
}

module "application" {
  source = "../modules/application"

  vpc_id              = module.vpc.vpc_id
  load_balancer_sg_id = module.load_balancer.load_balancer_sg_id
  bastian_sg_id       = module.bastian.bastian_sg_id
}

module "database" {
  source = "../modules/database"

  vpc_id            = module.vpc.vpc_id
  bastian_sg_id     = module.bastian.bastian_sg_id
  application_sg_id = module.application.application_sg_id
}
resource "aws_s3_bucket" "pipeline_store" {
  bucket        = "${var.project_name}-${var.environment_name}-pipeline-store"
  acl           = "private"
  force_destroy = true
}

data "template_file" "buildspec" {
  template = file("${path.module}/buildspec.yml")

  vars = {
    ecr_repository_url = var.ecr_repository_url
    region             = var.region
    rails_env          = var.environment_name
    cluster_name       = var.ecs_cluster_name
    rails_master_key   = var.rails_master_key
  }
}

resource "aws_codebuild_project" "codebuild_project" {
  name          = "${var.project_name}-${var.environment_name}-codebuild-project"
  build_timeout = 10
  service_role  = aws_iam_role.codebuild_role.arn

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type    = "BUILD_GENERAL1_SMALL"
    image           = "aws/codebuild/standard:5.0"
    type            = "LINUX_CONTAINER"
    privileged_mode = true
  }

  source {
    type      = "CODEPIPELINE"
    buildspec = data.template_file.buildspec.rendered
  }
}


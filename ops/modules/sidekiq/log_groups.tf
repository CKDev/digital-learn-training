resource "aws_cloudwatch_log_group" "sidekiq_log_group_legacy" {
  name              = "/ecs/sidekiq-${var.environment_name}"
  retention_in_days = var.log_retention_days

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_cloudwatch_log_group" "sidekiq_log_group" {
  name              = "${var.project_name}/${var.environment_name}/ecs/sidekiq"
  retention_in_days = var.log_retention_days

  lifecycle {
    prevent_destroy = true
  }
}
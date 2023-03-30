resource "aws_cloudwatch_log_group" "app_instance" {
  name              = "dl-training-app-log-group-${var.environment_name}"
  retention_in_days = var.log_retention_days
}

resource "aws_cloudwatch_log_group" "sidekiq_instance" {
  name              = "dl-training-sidekiq-log-group-${var.environment_name}"
  retention_in_days = var.log_retention_days
}

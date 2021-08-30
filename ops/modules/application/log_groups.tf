resource "aws_cloudwatch_log_group" "instance" {
  name = "dl-training-log-group-${var.environment_name}"
}

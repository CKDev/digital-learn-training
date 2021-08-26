resource "aws_ecs_cluster" "training-cluster" {
  name = "dl-training-cluster-${var.environment_name}"
}

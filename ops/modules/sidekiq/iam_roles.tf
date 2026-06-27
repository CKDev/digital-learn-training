# This IAM role is used by the ECS instances to run the Sidekiq workers.
resource "aws_iam_role" "sidekiq_ecs_instance_role" {
  name = "${var.project_name}-${var.environment_name}-sidekiq-instance-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        Service = "ec2.amazonaws.com"
      },
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_instance_policy" {
  role       = aws_iam_role.sidekiq_ecs_instance_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}

resource "aws_iam_role_policy_attachment" "ecr_read_policy" {
  role       = aws_iam_role.sidekiq_ecs_instance_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

resource "aws_iam_role_policy_attachment" "cloudwatch_logs_policy" {
  role       = aws_iam_role.sidekiq_ecs_instance_role.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}

resource "aws_iam_policy" "sidekiq_s3" {
  name   = "${var.project_name}-${var.environment_name}-sidekiq-s3"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid      = "S3ListBuckets"
        Effect   = "Allow"
        Action   = "s3:ListBucket"
        Resource = var.s3_bucket_arns
      },
      {
        Sid      = "S3ObjectRW"
        Effect   = "Allow"
        Action   = ["s3:GetObject", "s3:PutObject", "s3:DeleteObject", "s3:PutObjectAcl"]
        Resource = [for arn in var.s3_bucket_arns : "${arn}/*"]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "sidekiq_s3" {
  role       = aws_iam_role.sidekiq_ecs_instance_role.name
  policy_arn = aws_iam_policy.sidekiq_s3.arn
}

resource "aws_iam_instance_profile" "sidekiq_instance_profile" {
  name = "${var.project_name}-${var.environment_name}-sidekiq-ecs-profile"
  role = aws_iam_role.sidekiq_ecs_instance_role.name
}

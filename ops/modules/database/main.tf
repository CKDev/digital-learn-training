resource "aws_db_subnet_group" "application" {
  name = "${var.environment_name}-db-subnet-group"
  subnet_ids = [
    var.private_subnet_a_id,
    var.private_subnet_b_id
  ]

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_db_instance" "app_db" {
  allocated_storage               = var.instance_storage
  storage_type                    = "gp2"
  engine                          = "postgres"
  engine_version                  = "13.3"
  instance_class                  = var.instance_size
  monitoring_interval             = var.monitoring_interval
  name                            = var.database_name
  username                        = var.db_user
  password                        = var.db_password
  vpc_security_group_ids          = [aws_security_group.database_sg.id]
  availability_zone               = "${var.region}a"
  multi_az                        = false
  db_subnet_group_name            = aws_db_subnet_group.application.name
  identifier                      = var.rds_identifier
  skip_final_snapshot             = var.skip_final_snapshot
  final_snapshot_identifier       = "${var.environment_name}-final-snapshot"
  backup_retention_period         = var.backup_retention
  deletion_protection             = true
  enabled_cloudwatch_logs_exports = ["postgresql", "upgrade"]
  performance_insights_enabled    = true
  copy_tags_to_snapshot           = true

  lifecycle {
    prevent_destroy = true
  }
}

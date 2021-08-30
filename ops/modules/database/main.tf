resource "aws_db_subnet_group" "application" {
  name       = "${var.environment_name}-db-subnet-group"
  subnet_ids = var.private_subnet_ids

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_db_instance" "app_db" {
  snapshot_identifier             = var.db_snapshot_name
  engine_version                  = "13.1"
  allow_major_version_upgrade     = true
  instance_class                  = var.instance_size
  monitoring_interval             = var.monitoring_interval
  vpc_security_group_ids          = [aws_security_group.db_sg.id]
  availability_zone               = "${var.region}a"
  multi_az                        = false
  db_subnet_group_name            = aws_db_subnet_group.application.name
  identifier                      = var.rds_identifier
  skip_final_snapshot             = var.skip_final_snapshot
  final_snapshot_identifier       = "${var.environment_name}-final-snapshot"
  backup_retention_period         = var.backup_retention
  enabled_cloudwatch_logs_exports = ["postgresql", "upgrade"]
  performance_insights_enabled    = true
  copy_tags_to_snapshot           = true
  deletion_protection             = true

  lifecycle {
    prevent_destroy = true
  }
}

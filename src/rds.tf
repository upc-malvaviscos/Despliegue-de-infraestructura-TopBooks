# ==============================================================================
# Database Subnet Group
# ==============================================================================
resource "aws_db_subnet_group" "rds_subnet_group" {
  name        = "topbooks-rds-subnet-group"
  description = "Private subnet group for the TopBooks database"

  # Grouping the two private subnets created in the networking module
  subnet_ids = [
    aws_subnet.private_subnet_1.id,
    aws_subnet.private_subnet_2.id
  ]

  tags = merge(local.tags_obligatorios, {
    Name = "topbooks-rds-subnet-group"
  })
}

# ==============================================================================
# RDS MySQL Instance and Security Group Association
# ==============================================================================
resource "aws_db_instance" "mysql_db" {
  allocated_storage     = 20  # Minimum recommended storage for testing
  max_allocated_storage = 100 # Enables storage autoscaling
  engine                = "mysql"
  engine_version        = "8.0"
  instance_class        = "db.t3.micro"

  # Credenciales de la base de datos
  db_name  = "topbooks_db"
  username = var.db_user_name
  password = var.db_password


  db_subnet_group_name   = aws_db_subnet_group.rds_subnet_group.name
  vpc_security_group_ids = [aws_security_group.db_sg.id]

  skip_final_snapshot = true
  publicly_accessible = false # Keep the database private within the VPC

  tags = merge(local.tags_obligatorios, {
    Name = "topbooks-rds-mysql"
  })
}


resource "aws_db_subnet_group" "rds_subnet_group" {
  name        = "topbooks-rds-subnet-group"
  description = "Private subnet group for the TopBooks database"

  subnet_ids = [
    aws_subnet.private_subnet_1.id,
    aws_subnet.private_subnet_2.id
  ]

  tags = merge(local.common_tags, {
    Name = "topbooks-rds-subnet-group"
  })
}

resource "aws_db_instance" "mysql_db" {
  allocated_storage     = 20
  max_allocated_storage = 100
  engine                = "mysql"
  engine_version        = "8.0"
  instance_class        = "db.t3.micro"

  db_name  = "topbooks_db"
  username = var.db_user_name
  password = var.db_password

  db_subnet_group_name   = aws_db_subnet_group.rds_subnet_group.name
  vpc_security_group_ids = [aws_security_group.db_sg.id]

  skip_final_snapshot = true
  publicly_accessible = false

  tags = merge(local.common_tags, {
    Name = "topbooks-rds-mysql"
  })
}

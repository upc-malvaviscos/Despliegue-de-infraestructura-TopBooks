# Web server security group
resource "aws_security_group" "web_sg" {
  name        = "topbooks-web-sg"
  description = "Allow HTTP and HTTPS traffic from the internet"
  vpc_id      = aws_vpc.main_vpc_topbooks.id

  # AWS security group descriptions are immutable; preserve existing groups during migration.
  lifecycle {
    ignore_changes = [description]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.common_tags, { Name = "topbooks-web-sg" })
}

# Database security group
resource "aws_security_group" "db_sg" {
  name        = "topbooks-db-sg"
  description = "Allow MySQL traffic only from the web server security group"
  vpc_id      = aws_vpc.main_vpc_topbooks.id

  # AWS security group descriptions are immutable; preserve existing groups during migration.
  lifecycle {
    ignore_changes = [description]
  }

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.web_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.common_tags, { Name = "topbooks-db-sg" })
}

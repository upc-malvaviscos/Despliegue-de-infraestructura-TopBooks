# Grupo de Seguridad para el Servidor Web 


# GRUPO DE SEGURIDAD DE LA BD 
resource "aws_security_group" "db_sg" {
  name        = "topbooks-db-sg"
  description = "Permitir acceso a MySQL solo desde el servidor web"
  vpc_id      = aws_vpc.main_vpc_topbooks_malvaviscos.id

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.web_sg.id] # estricting traffic exclusively to the Web SG
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.tags_obligatorios, { Name = "topbooks-db-sg" })
}
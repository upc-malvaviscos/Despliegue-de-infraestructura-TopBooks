# ==============================================================================
# Grupo de subredes de la Base de Datos (DB Subnet Group)
# ==============================================================================
resource "aws_db_subnet_group" "rds_subnet_group" {
    name        = "topbooks-rds-subnet-group"
    description = "Grupo de subredes privadas para la base de datos de TopBooks"
    
    # Agrupamos las dos subredes privadas creadas en el módulo de redes
    subnet_ids  = [
        aws_subnet.private_subnet_1.id,
        aws_subnet.private_subnet_2.id
    ]

    tags = merge(local.tags_obligatorios, {
        Name = "topbooks-rds-subnet-group"
    })
}

# ==============================================================================
# Instancia RDS MySQL y asociar el Security Group
# ==============================================================================
resource "aws_db_instance" "mysql_db" {
    allocated_storage      = 20                  # Almacenamiento mínimo recomendado para pruebas
    max_allocated_storage  = 100                 # Habilita el autoescalado de almacenamiento 
    engine                 = "mysql"
    engine_version         = "8.0"               
    instance_class         = "db.t3.micro"       
    
    # Credenciales de la base de datos
    db_name                = "topbooks_db"
    username               = var.db_user_name
    password               = var.db_password
    

    db_subnet_group_name   = aws_db_subnet_group.rds_subnet_group.name
    vpc_security_group_ids = [aws_security_group.db_sg.id]
    
    skip_final_snapshot    = true              
    publicly_accessible    = false               # Mantenerla privada dentro de la VPC

    tags = merge(local.tags_obligatorios, {
        Name = "topbooks-rds-mysql"
    })
}


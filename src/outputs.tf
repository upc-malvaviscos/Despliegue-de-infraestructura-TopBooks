# Outputs will be added as resources are implemented in src/main.tf.
output "vpc_id" {
  description = "El ID de la VPC"
  value       = aws_vpc.main_vpc_topbooks_malvaviscos.id
}

output "public_subnet_id" {
  description = "El ID de la subred pública"
  value       = aws_subnet.public_subnet.id
}

output "private_subnet_id" {
  description = "El ID de la subred privada (se expone la primera como referencia principal)"
  value       = aws_subnet.private_subnet_1.id
}

output "web_sg_id" {
  description = "The ID of the web server security group"
  value = aws_security_group.web_sg.id
}

output "database_sg_id" {
  description = "The ID of the database security group"
  value       = aws_security_group.db_sg.id
}

output "ec2_instance_id" {
  description = "The EC2 web server instance ID"
  value = aws_instance.web_server.id
}

output "rds_endpoint" {
  description = "The connection endpoint for the RDS database"
  value = aws_db_instance.mysql_db.endpoint
}

output "s3_bucket_name" {
  description = "The storage bucket name"
  value = aws_s3_bucket.topbooks_bucket.bucket
}

output "vpc_endpoint_id" {
  description = "El ID del VPC Endpoint S3"
  value       = aws_vpc_endpoint.s3_endpoint_topbooks.id
}
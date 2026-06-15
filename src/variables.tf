variable "aws_region" {
  description = "AWS region where infrastructure will be deployed."
  type        = string
  default     = "us-east-1"
}

variable "group_name" {
  description = "UPC-Malavaviscos"
  type        = string
  default     = "equipo1"
}


variable "db_user_name" {
  description = "username for the TopBooks RDS MySQL instance"
  type = string
  sensitive = true
}

variable "db_password" {
  description = "password for the TopBooks RDS MySQL instance"
  type        = string
  sensitive   = true
}


locals {
  common_tags = {
    Project     = "topbooks"
    Environment = "dev"
    ManagedBy   = "Terraform"
    Group       = var.group_name
  }
}
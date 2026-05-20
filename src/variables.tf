variable "aws_region" {
  description = "AWS region where infrastructure will be deployed."
  type        = string
  default     = "us-east-1"
}

variable "group_name" {
  description = "Team name used in mandatory tags."
  type        = string
  default     = "equipo1"
}

locals {
  common_tags = {
    Project     = "topbooks"
    Environment = "dev"
    ManagedBy   = "Terraform"
    Group       = var.group_name
  }
}

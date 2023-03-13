# Define Local Values in Terraform
locals {
  environment = var.environment
  name = "jenkins-${var.environment}"
  common_tags = {
    environment = local.environment
  }
} 
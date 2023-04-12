# Terraform Settings Block
terraform {
  required_version = ">= 1.0.0"
  required_providers {
    null = {
      source = "hashicorp/null"
      version = "~> 3.1"
    }
  }
  # Adding Backend as S3 for Remote State Storage
  backend "s3" {
    bucket = "tfstate-mtekdevops"
    key    = "dev/eks-vpa-install/terraform.tfstate"
    region = "us-east-1" 

    # For State Locking
    dynamodb_table = "tflockDDB-mtekdevops-dev"    
  }     
}

provider "null" {
  # Configuration options
}
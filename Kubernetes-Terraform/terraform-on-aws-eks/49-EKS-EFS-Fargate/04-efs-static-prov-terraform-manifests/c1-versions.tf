# Terraform Settings Block
terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 4.62"
     }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.19"
    }     
  }
  # Adding Backend as S3 for Remote State Storage
  backend "s3" {
    bucket = "tfstate-mtekdevops"
    key    = "dev/efs-sampleapp-demo/terraform.tfstate"
    region = "us-east-1" 

    # For State Locking
    dynamodb_table = "tflockDDB-mtekdevops-dev"    
  }    
}


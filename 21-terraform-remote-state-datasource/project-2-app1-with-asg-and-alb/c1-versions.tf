# Terraform Block
terraform {
  required_version = ">= 1.0" # which means any version equal & above 0.14 like 0.15, 0.16 etc and < 1.xx
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.53.0"
    }
    null = {
      source = "hashicorp/null"
      version = "3.2.1"
    }        
    random = {
      source = "hashicorp/random"
      version = "3.4.3"
    }       
  }
  # Adding Backend as S3 for Remote State Storage
  backend "s3" {
    bucket = "tfstate-clean-dane"
    key    = "dev/project2-app1/terraform.tfstate"
    region = "us-east-1" 

    # Enable during Step-09     
    # For State Locking
    dynamodb_table = "tflockDDB-clean-dane-stag"    
  }     
}

# Provider Block
provider "aws" {
  region  = var.aws_region
  profile = "default"
}
/*
Note-1:  AWS Credentials Profile (profile = "default") configured on your local desktop terminal  
$HOME/.aws/credentials
*/

# Create Random Pet Resource
resource "random_pet" "this" {
  length = 2
}
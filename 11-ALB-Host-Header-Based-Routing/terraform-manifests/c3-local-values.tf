# Define Local Values in Terraform
locals {
  owners = var.business_divsion
  environment = var.environment
  name = "${var.business_divsion}-${var.environment}"
  app1_dns_name = "app1.${data.aws_route53_zone.mydomain.name}"
  app2_dns_name = "app2.${data.aws_route53_zone.mydomain.name}"
  #name = "${local.owners}-${local.environment}"
  common_tags = {
    owners = local.owners
    environment = local.environment
  }
} 
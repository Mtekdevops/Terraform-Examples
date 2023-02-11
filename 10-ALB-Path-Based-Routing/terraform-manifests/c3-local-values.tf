# Define Local Values in Terraform
locals {
  owners = var.business_divsion
  environment = var.environment
  name = "${var.business_divsion}-${var.environment}"
  #name = "${local.owners}-${local.environment}"
  no_dot_suffix_domain = trimsuffix(data.aws_route53_zone.mydomain.name, ".")
  common_tags = {
    owners = local.owners
    environment = local.environment
  }
} 
# ACM Module - To create and Verify SSL Certificates
module "acm" {
  source  = "terraform-aws-modules/acm/aws"
  version = "4.3.1"

  domain_name  = data.aws_route53_zone.mydomain.name
  zone_id      = data.aws_route53_zone.mydomain.zone_id 

  subject_alternative_names = [
    aws_route53_record.jenkins_dns.name 
  ]
}

# Output ACM Certificate ARN
output "acm_certificate_arn" {
  description = "The ARN of the certificate"
  value       = module.acm.acm_certificate_arn
}


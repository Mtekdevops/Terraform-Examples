# AWS EC2 Instance Terraform Variables
# EC2 Instance Variables

# AWS EC2 Instance Type
variable "instance_type" {
  description = "EC2 Instance Type"
  type = string
  default = "t3.micro"  
}

# USING SELF GENERATED KEY
# # AWS EC2 Instance Key Pair
# variable "instance_keypair" {
#   description = "AWS EC2 Key pair that need to be associated with EC2 Instance"
#   type = string
#   default = "terraform-key"
# }
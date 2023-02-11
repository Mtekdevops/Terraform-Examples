resource "tls_private_key" "privkey" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "private_inst_key" {
  key_name   = "Priv-Inst-Key"
  public_key = "${tls_private_key.privkey.public_key_openssh}"
}

# EC2 Instances that will be created in VPC Private Subnets
module "ec2_private" {
  depends_on = [ module.vpc ] # VERY VERY IMPORTANT else userdata webserver provisioning will fail
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "4.2.1"
  #  for_each = toset([ module.vpc.private_subnets[0],module.vpc.private_subnets[1] ])
   for_each = toset(["0", "1"])
  # insert the 10 required variables here
  name                   = "${var.environment}-vm-${each.key}"
  ami                    = data.aws_ami.amzlinux2.id
  instance_type          = var.instance_type
  key_name               = aws_key_pair.test_key.key_name
  #monitoring             = true
  vpc_security_group_ids = [module.private_sg.security_group_id]
  
  subnet_id              = element(module.vpc.private_subnets, tonumber(each.key))
  user_data = file("${path.module}/app1-install.sh")
  tags = local.common_tags
}



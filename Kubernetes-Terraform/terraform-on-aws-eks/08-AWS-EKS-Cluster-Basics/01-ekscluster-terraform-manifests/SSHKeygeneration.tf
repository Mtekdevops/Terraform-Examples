# Ideally you would probably manage your SSH keys outside of terraform to avoid them appearing in clear text in the state file (even through you are using secure state storage right....?)
# Also have different keys for different private and public environments especially in production.   
# but since I am using ephemeral AWS environments and dont have a pre-existing key to reference, its more self-contained to specify here. 

resource "tls_private_key" "test_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "test_key" {
  key_name   = "eks-terraform-key"
  public_key = "${tls_private_key.test_key.public_key_openssh}"
}

resource "local_file" "test_key" {
  content         = tls_private_key.test_key.private_key_pem
  filename        = "eks-terraform-key.pem"
  file_permission = "0600"
}
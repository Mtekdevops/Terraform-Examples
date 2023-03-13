resource "aws_iam_instance_profile" "SSMProfile" {
  name = "SSMProfile"
  role = aws_iam_role.SSMRole.name
}

resource "aws_iam_role" "SSMRole" {
  name = "SSMRole"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "SSMRoleAttachment1" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  role       = aws_iam_role.SSMRole.name
}

resource "aws_iam_role_policy_attachment" "SSMRoleAttachment2" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMPatchAssociation"
  role       = aws_iam_role.SSMRole.name
}
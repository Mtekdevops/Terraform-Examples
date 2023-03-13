output "Instance_Profile_ARN" {
  description = "ARN of the newly created instance profile"
  value       = aws_iam_instance_profile.SSMProfile.arn
}
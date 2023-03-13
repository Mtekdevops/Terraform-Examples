## Full Terraform jenkins installation with VPC setup 

Instance is hosted in a Private Subnet behind an ALB and is accessible via SSH without having to manage and maintain a bastion host using SSM Session Manager 

Install the Session manager AWS CLI plugin 

https://docs.aws.amazon.com/systems-manager/latest/userguide/session-manager-working-with-install-plugin.html

optionally setup SSH proxying to tunnel native SSH through Session Manager 

(allows you to use native ssh and scp commands like 'ssh ec2-user@i-xxxxxxxx' instead of ssm commands)

https://docs.aws.amazon.com/systems-manager/latest/userguide/session-manager-getting-started-enable-ssh-connections.html

or 

https://dev.to/aws-builders/how-to-set-up-session-manager-and-enable-ssh-over-ssm-43k9
## ECR/ECS-Docker NodeJS Example 

This deploys an ECR repo and an EC2 ECS cluster which will run the Docker NodeJS example image that is build and uploaded to the ECR repo

### Deployment steps 

0. generate ssh public / private keys called `mykey` and place them in the root directory (or change the variable in vars.tf to where your key lives)<br><br>
`ssh-keygen -t rsa`

1. create the ECR repository first, this can be done by using the resource targeting flag 

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`terraform apply --target="aws_ecr_repository.myapp" `

2. build the docker container using the dockerfile included in the `\docker-build` directory <br>
(the `FROM --platform=linux/amd64 node:11.15` is included otherwise it doesnt build correctly on ARM-based MAC's)<br> <br>
`docker build -t xxxxxxxxxxxx.dkr.ecr.us-east-1.amazonaws.com/myapp:latest`<br><br>
where xxxxxxxxxxxx is the ecr repo number that you have created

3. login and upload the container to ecr <br><br>
`aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin xxxxxxxxxxxx.dkr.ecr.us-east-1.amazonaws.com` <br><br>
`docker push xxxxxxxxxxxx.dkr.ecr.us-east-1.amazonaws.com/myapp:latest`

4. Apply the rest of the Terraform config <br><br> 
`terraform apply`

5. use SSM session manager to log into the ECS cluster instance <br><br>
Instance is accessible without having to expose anything to the internet using SSH tunneled through SSM Session Manager<br><br> 
Install the Session manager AWS CLI plugin<br><br> 
https://docs.aws.amazon.com/systems-manager/latest/userguide/session-manager-working-with-install-plugin.html<br><br>
optionally setup SSH proxying to tunnel native SSH through Session Manager<br><br>
(allows you to use native ssh and scp commands like 'ssh ec2-user@i-xxxxxxxx' instead of ssm commands)<br><br>
https://docs.aws.amazon.com/systems-manager/latest/userguide/session-manager-getting-started-enable-ssh-connections.html<br><br>
or <br><br>
https://dev.to/aws-builders/how-to-set-up-session-manager-and-enable-ssh-over-ssm-43k9

6. check that the container is running on the ECS cluster<br><br>
use `docker ps` to check the containers are running correctly and you can `curl localhost:3000` 
# Valheim

My rough plan to get Valheim running in an AWS instance.

- [x]  Create Terraform for EC2 Instance, VPC, Subnet, Internet Gateway
- [x]  Investigate some way to mount persistent storage into the EC2 instance
- [x]  Adjust the EC2 Instance to use that persistent storage and mount it and then volume mount the valheim container to that.
- [x]  Get the above working and then move to compose
- [ ]  Figure out how to get this all running on Kubernetes


I was able to achieve what I had set out to on this project - setup and configure a valheim instance on ec2 with terraform. The current terraform in this repo will configure the right infrastructure for an ec2 instance to run in but there are ultimately some issues with destroying the valheim container and its interaction with persistent storage for world saves that have lead to me moving on from this project
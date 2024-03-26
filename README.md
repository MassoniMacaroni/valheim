# valheim

My rough plan to get Valheim running in an AWS instance.

- [ ]  Create Terraform for EC2 Instance, VPC, Subnet, Internet Gateway
- [ ]  Investigate some way to mount persistent storage into the EC2 instance
- [ ]  Adjust the EC2 Instance to use that persistent storage and mount it and then volume mount the valheim container to that.
- [ ]  Get the above working and then move to compose
- [ ]  Figure out how to get this all running on Kubernetes

provider "aws" {
  region = "ap-southeast-2"
}

module "vpc" {
  source = "./modules/VPC"
}


module "ec2" {
  source = "./modules/EC2"
  subnet_id =  module.vpc.public_subnet_1_id
}
variable "volume-size" {
  type        = number
  default = 8
}

variable "ami_id" {
  type        = string
  description = "AMI Id of the ec2 instance"
  default = "ami-0fb76f0c92f96a9df"
}

variable "instance_type" {
  type        = string
  description = "Instance type of the ec2 instance"
  default = "t2.micro"
}

variable "instance_count" {
  type        = number
  description = "Count of the ec2 instances"
  default = 1
}

variable "instance_name" {
  type        = string
  description = "The name of the instance."
  default = "EC2-Valheim"
}

variable "subnet_id" {
  type        = string
  description = "instance subnet id"
}

variable "security_group_ids" {
  description = "List of security group IDs to attach to the EC2 instance."
  type        = list(string)
}
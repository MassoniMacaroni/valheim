resource "aws_instance" "ec2_instance" {
  ami           = var.ami_id
  instance_type = var.instance_type
  count         = var.instance_count
  user_data = base64encode(file("${path.module}/userData.sh")) 

  root_block_device {
    volume_size = var.volume-size  # Size in GB
    volume_type = "gp2"  # EBS volume type
  }
  
  vpc_security_group_ids = var.security_group_ids

  subnet_id = var.subnet_id

  tags = merge(
    {
      Name        = var.instance_name
    }
  )
} 
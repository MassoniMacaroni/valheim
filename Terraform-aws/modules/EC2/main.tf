resource "aws_instance" "ec2_instance" {
  ami           = var.ami_id
  instance_type = var.instance_type
  count         = var.instance_count
  user_data = base64encode(file("${path.module}/userData.sh")) 
  key_name = var.key_name

  root_block_device {
    volume_size = var.volume-size  # Size in GB
    volume_type = "gp3"  # EBS volume type
  }
  
  vpc_security_group_ids = var.security_group_ids

  subnet_id = var.subnet_id

  tags = merge(
    {
      Name        = var.instance_name
    }
  )
} 

resource "aws_volume_attachment" "ebs_att" {
  device_name = "/dev/sdh"
  volume_id   = var.volume_id
  instance_id = aws_instance.ec2_instance[0].id
}

resource "null_resource" "stop_docker" {
  provisioner "local-exec" {
    when    = destroy
    command = "ssh -i ${var.private_key_path} ec2-user@${aws_instance.ec2_instance[0].public_ip} 'bash docker stop valheim-server-valheim-1'"
  }

  depends_on = [aws_instance.ec2_instance]
}
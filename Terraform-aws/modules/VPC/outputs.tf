
output "public_subnet_1_id" {
  value = element(aws_subnet.public_subnets, 0).id
}
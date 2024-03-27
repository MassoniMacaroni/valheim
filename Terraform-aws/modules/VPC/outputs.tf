output "public_subnet_1_id" {
  value = element(aws_subnet.public_subnets, 0).id
}

output "security_group_ids" {
  description = "ID of the security group."
  value       = aws_security_group.SG_valheim.*.id
}
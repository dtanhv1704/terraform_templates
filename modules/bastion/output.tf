output "bastion_id" {
  value = aws_instance.bastion.*.id
}
output "bastion_sg" {
	value = aws_security_group.bastion-sg.id
}
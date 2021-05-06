output "vpc_id" {
  value = module.network.vpc_id
}

output "public_subnet" {
  # value = element(aws_subnet.public-subnet.*.id, 0)
	value = module.network.public_subnet
}

output "private_subnet" {
  value	=	module.network.private_subnet
}

output "bastion_id" {
  value = module.bastion.bastion_id
}
output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "public_subnet" {
  # value = element(aws_subnet.public-subnet.*.id, 0)
	value = aws_subnet.public-subnet.*.id
}

output "private_subnet" {
  value	=	aws_subnet.private-subnet.*.id
}
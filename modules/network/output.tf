output "vpc_id" {
    value = aws_vpc.vpc.id
}

output "public_subnet" {
    value = element(aws_subnet.public-subnet.*.id, 0)
}
# Allocate Elastic IP for Bastion host
resource "aws_eip" "eip-bastion" {
  vpc = true

  tags = merge(
    var.default_tags,
    {
      Name  = "${var.project_name}-eip-bastion"
    }
  )
}

# Bastion host
resource "aws_instance" "bastion" {
  ami           = data.aws_ami.ubuntu.id #Use data to get AMI ID for defined OS
  # ami           = var.ami_id
  # instance_type = var.bastion_size
  instance_type = lookup(var.instance_size, "bastion") # Lookup instance size for bastion instance in variable
  key_name      = lookup(var.key_pair, "bastion") # Lookup key pair for bastion instance in variable
  subnet_id     = element(aws_subnet.public-subnet.*.id, 0)
  vpc_security_group_ids = [aws_security_group.bastion-sg.id]

  volume_tags = merge(
    var.default_tags,
    {
      Name  = "${var.project_name}-bastion"
    }
  )

  tags = merge(
    var.default_tags,
    {
      Name  = "${var.project_name}-bastion"
    }
  )
}

resource "aws_eip_association" "eip-for-bastion" {
  instance_id   = aws_instance.bastion.id
  allocation_id = aws_eip.eip-bastion.id
}

# Bastion Security group
resource "aws_security_group" "bastion-sg" {
  name        = "${var.project_name}-sg-bastion"
  description = "Security for bastion host"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    description = "Allow SSH to bastion"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    var.default_tags,
    {
      Name  = "${var.project_name}-sg-bastion"
    }
  )
}
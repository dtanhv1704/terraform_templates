# Create Prod instances
resource "aws_instance" "web" {
    count         = 2
    ami           = data.aws_ami.ubuntu.id #Use data to get AMI ID for defined OS
    # ami           = var.ami_id
    # instance_type = var.bastion_size
    instance_type = lookup(var.instance_size, "prod") # Lookup instance size for bastion instance in variable
    key_name      = lookup(var.key_pair, "prod") # Lookup key pair for bastion instance in variable
    subnet_id     = element(aws_subnet.private-subnet.*.id,count.index)
    vpc_security_group_ids = [aws_security_group.web-sg.id]

    volume_tags = merge(
        var.default_tags,
        {
            Name = "${var.project_name}-web-${count.index+1}"
        }
    )

    tags = merge(
        var.default_tags,
        {
            Name  = "${var.project_name}-web-${count.index+1}"
        }
    )
}

# Prod instances Security group
resource "aws_security_group" "web-sg" {
    name        = "${var.project_name}-sg-web"
    description = "Security for Web instances"
    vpc_id      = aws_vpc.vpc.id
    
    ingress {
        description = "Allow SSH from bastion"
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"

        # Use "security_groups" to allow connection from AWS securirty groups
        security_groups = [aws_security_group.bastion-sg.id] 
    }

    ingress {
        description = "Allow HTTP to web instances"
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"

        security_groups = [aws_security_group.alb-sg.id]
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"

        # User "cidr_blocks" to allow connection from IPs/IPs range
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = merge(
        var.default_tags,
        {
            Name  = "${var.project_name}-sg-web"
        }
    )
}




# Application Load Balancer
resource "aws_lb" "alb" {
	name               = "${var.project_name}-alb"
	internal           = false
	load_balancer_type = "application"
	security_groups    = [aws_security_group.alb-sg.id]
	subnets            = aws_subnet.public-subnet.*.id
	
	enable_deletion_protection = false
	
	# access_logs {
	#     bucket  = aws_s3_bucket.lb_logs.bucket
	#     prefix  = "test-lb"
	#     enabled = true
	# }
	
	tags = merge(
		var.default_tags,
		{
			Name = "${var.project_name}-alb"
		}
	)
	#     {
	#     Environment = "production"
	# }
  # (resource arguments)
}

# ALB Security group
resource "aws_security_group" "alb-sg" {
	name        = "${var.project_name}-sg-alb"
	description = "Security group for ALB"
	vpc_id      = aws_vpc.vpc.id
	
	ingress {
		description = "Allow HTTP to ALB"
		from_port   = 80
		to_port     = 80
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
			Name  = "${var.project_name}-sg-alb"
		}
	)
}
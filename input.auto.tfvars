profile			= "vti-training"
project_name	= "tflab"
region			= "ap-northeast-2"

# Default tags
default_tags 	= {
	Owner 		= "anh.dinhtuan1"
	Environment = "tf-demo"
  }
# Bastion Input
bastion_keypair	= "tadi-lab"
bastion_size	= "t2.micro"

# Network input
vpc_cidr			= "11.12.0.0/16"
public_subnet_cidr 	= ["11.12.1.0/24", "11.12.2.0/24"]
private_subnet_cidr	= ["11.12.11.0/24", "11.12.12.0/24"]
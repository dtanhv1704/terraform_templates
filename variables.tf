variable "profile" {
	default = "labacc-ngloc"
	# default = "vti-training" # AWS profile for provisioning
	description = "AWS profile for provisioning"
}

variable "project_name" {
  	default = "tflab" # Project name, use as prefix for tagging resource name
	description = "The project name, use as prefix for tagging resource name"
}

variable "ami_id" {
	default = "ami-0c20b8b385217763f"
	description = "Ubuntu Server 20.04"
}

variable "additional_tags" {
  	default 		= {
		Owner 		= "anh.dinhtuan1"
		Environment = "demo"
  	}
  	description = "Additional resource tags" # Additional tag for resources
  	type        = map(string)
}

variable "region" {
	# default = "ap-southeast-1"
	default = "ap-northeast-2"
}

# variable "azs" {
# 	type = list
# 	default = ["ap-southeast-1a", "ap-southeast-1b", "ap-southeast-1c"]
# }

variable "vpc_cidr" {
    default = "10.100.0.0/16"
}

variable "public_subnet_cidr" {
	type = list
	default = ["10.100.1.0/24", "10.100.2.0/24", "10.100.3.0/24"]
}

variable "private_subnet_cidr" {
	type = list
	default = ["10.100.11.0/24", "10.100.12.0/24", "10.100.13.0/24"]
}

variable "instance_size" {
	type 	= map(string)
	default = {
		bastion = "t2.micro"
		prod	= "t3.small"
	}
	description = "Map value of instance size for each environment"
}

variable "key_pair" {
	type 	= map(string)
	default = {
		bastion = "tadi-lab"
		prod	= "tadi-lab"
	}
	description = "Map key pair file for each instance type"
}

# variable "bastion_size" {
# 	default = "t2.micro"
# }
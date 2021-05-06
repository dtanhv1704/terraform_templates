variable "profile" {
	# default = "default"
	# default = "vti-training" # AWS profile for provisioning
	description = "AWS profile for provisioning"
}

variable "region" {
	# default = "ap-southeast-1"
	# default = "ap-northeast-2"
}

variable "project_name" {
  # default = "tflab" # Project name, use as prefix for tagging resource name
	description = "The project name, use as prefix for tagging resource name"
}

variable "default_tags" {
  	description = "Default tags for all provisioned resource" # Additional tag for resources
  	type        = map(string)
	# Example
	# default 		= {
	# 	Owner 		= "anh.dinhtuan1"
	# 	Environment = "demo"
  # 	}
}

variable "vpc_cidr" {
  description = "Define CIDR for VPC"
#   default = "10.100.0.0/16"
}

variable "public_subnet_cidr" {
	description = "List of subnet cidr for public subnet"
	type = list
	# default = ["10.100.1.0/24", "10.100.2.0/24", "10.100.3.0/24"]
}

variable "private_subnet_cidr" {
	description = "List of subnet cidr for private subnet"
	type = list
	# default = ["10.100.11.0/24", "10.100.12.0/24", "10.100.13.0/24"]
}
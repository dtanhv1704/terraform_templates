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

variable "vpc_id" {}
variable "subnet_id" {}
# variable "bastion_ami" {
#   description = "AMI ID of bastion"
# }
variable "bastion_size" {
  description	= "Instance size of bastion"
}
variable "bastion_keypair" {
	description	=	"Key pair of bastion/jump host"
}
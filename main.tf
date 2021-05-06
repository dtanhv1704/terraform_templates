# Create network environment using module
module "network" {
  source	=	"./modules/network"

# Define AWS profile for provisioning
	profile				= var.profile
	
# Environment parameter	
	region				=	var.region
	project_name	=	var.project_name

# Network parameter input
	vpc_cidr						=	var.vpc_cidr
	public_subnet_cidr	=	var.public_subnet_cidr
	private_subnet_cidr	=	var.private_subnet_cidr
	default_tags	=	var.default_tags
}

 module "bastion" {
	source	=	"./modules/bastion"
 	# Environment parameter
 	vpc_id 				= module.network.vpc_id
	subnet_id			=	module.network.public_subnet
 	default_tags	=	var.default_tags
 	project_name	=	var.project_name
 	# vpc_id				= var.vpc_id
 }
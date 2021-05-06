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
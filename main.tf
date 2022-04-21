module "alb" {
  source = "./modules/alb"
  environment_name = "dev"
  subnet_ids = module.network.subnet_ids
  cidr_block = module.network.cidr_block 
  vpc_security_group_ids = module.network.vpc_security_group_ids
  vpc = module.network.vpc

} 

module "asg" {
  source = "./modules/asg"
} 

module "compute" {
  source = "./modules/compute"
  environment_name = var.environment_name 
  subnet_ids = module.network.subnet_ids
  vpc_security_group_ids = module.network.vpc_security_group_ids
} 

module "database" {
  source = "./modules/database"
  
  
} 

module "iam" {
  source = "./modules/iam"
  environment_name = var.environment_name
  vpc = module.network.vpc
} 

module "network" {
  source = "./modules/network"
  environment_name = var.environment_name
  alb_id = module.alb.alb_arn
  lb_dns_name = module.alb.lb_dns_name
  bastion1_instance = module.compute.bastion1_instance
} 
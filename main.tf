module "alb" {
  source                 = "./modules/alb"
  environment_name       = var.environment_name
  subnet_ids             = module.network.subnet_ids
  cidr_block             = module.network.cidr_block
  vpc_security_group_ids = module.network.vpc_security_group_ids
  vpc                    = module.network.vpc

}

module "asg" {
  source                    = "./modules/asg"
  name_prefix               = var.name_prefix
  ami                       = var.ami
  instance_type             = var.instance_type
  max_size                  = var.max_size
  min_size                  = var.min_size
  health_check_grace_period = var.health_check_grace_period
  desired_capacity          = var.desired_capacity
  placement_strategy        = var.placement_strategy
  asg_name = "${var.app_name}-${var.environment_name}" 
  vpc_id = module.network.vpc 
  target_group_arn = module.alb.alb_target_group

}

module "compute" {
  source                 = "./modules/compute"
  environment_name       = var.environment_name
  subnet_ids             = module.network.subnet_ids
  vpc_security_group_ids = module.network.vpc_security_group_ids["b_sg"]
  bastion_instance_type  = var.bastion_instance_type
  bastion_ami            = var.bastion_ami
}

module "database" {
  source                = "./modules/database"
  storage               = var.storage
  max_storage           = var.max_storage
  storage_type          = var.storage_type
  db_engine             = var.db_engine
  db_engine_version     = var.db_engine_version
  aws_db_instance_class = var.aws_db_instance_class
  rds_name              = "${var.app_name}-${var.environment_name}-database"


}

module "iam" {
  source                  = "./modules/iam"
  environment_name        = var.environment_name
  vpc                     = module.network.vpc
  app_name                = var.app_name
  log_role_name           = var.log_role_name
  rate                    = var.rate
  log_watcher_policy_name = var.log_watcher_policy_name
  canary_handler          = var.canary_handler
  canary_role_name        = var.canary_role_name
  canary_runtime          = var.canary_runtime
  canary_role_policy_name = var.canary_role_policy_name

}

module "network" {
  source              = "./modules/network"
  environment_name    = var.environment_name
  alb_id              = module.alb.alb_arn
  lb_dns_name         = module.alb.lb_dns_name
  bastion1_instance   = module.compute.bastion1_instance
  az                  = var.az
  app_name            = var.app_name
  allowed_cidr_blocks = var.allowed_cidr_blocks
  hosted_domain       = var.hosted_domain
  cidr_block          = var.cidr_block

} 
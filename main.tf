module "alb" {
  source = "./modules/alb"
} 

module "asg" {
  source = "./modules/asg"
} 

module "compute" {
  source = "./modules/compute"
} 

module "database" {
  source = "./modules/database"
} 

module "iam" {
  source = "./modules/iam"
} 

module "network" {
  source = "./modules/network"
} 
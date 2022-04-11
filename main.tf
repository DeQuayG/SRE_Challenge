module "vpc" {
  vpc_id = module.aws_vpc.app_vpc.id
  source = "github.com:DeQuayG/SRE_Challenge"
}
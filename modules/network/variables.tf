### Subnets.tf Variables ###
variable "app_name" {
  default = "web_app"
} 

variable "az" {
    type = list
    default = ["us-east-1a", "us-east-1b"]
} 

variable "cidr_block" { 
    type = map 
    default = {
        "vpc"          = "10.1.0.0/16"
        "public_subnet_1" = "10.1.0.0/24" 
        "public_subnet_2" = "10.1.1.0/24" 
        "private_subnet_1" = "10.1.2.0/24"
        "private_subnet_1" = "10.1.3.0/24"  
        "data_subnet_1" = "10.1.4.0/24" 
        "data_subnet_2" = "10.1.5.0/24" 
    }
}

variable "allowed_cidr_blocks" {
    type = list
    description = "External CIDR blocks that allowed to communicate with the ALB"
    default = [""]
} 


### Route53 Variables #####
variable "environment_name" {
  default = "dev"
} 

variable "hosted_domain" {
  default = "www.example.com"
} 

variable "alb_id" {
  type = string
} 

variable "lb_dns_name" {
  type = string
}

variable "bastion1_instance" {
  type = string
}
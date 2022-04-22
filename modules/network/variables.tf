### Subnets.tf Variables ###
variable "app_name" {
} 

variable "az" {
    type = list
} 

variable "cidr_block" { 
    type = map 
}

variable "allowed_cidr_blocks" {
    type = list
    description = "External CIDR blocks that allowed to communicate with the ALB"
} 


### Route53 Variables #####
variable "environment_name" {
} 

variable "hosted_domain" {
  description = "The name you'd like to give your hosted domain"
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
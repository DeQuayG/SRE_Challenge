variable "placement_strategy" {
  description = "Method with which your ASG places the scaled out EC2 Instances"
} 

variable "name_prefix" {
  type = string
} 

variable "ami" {
  description = "The 'Amazon Machine Image' that you would like to use" 
} 

variable "instance_type" {
  description = "Category of instance example: t2.micro"
} 

variable "max_size" {
  type = number  
  description = "The maximum amount of instances, the ceiling of the asg expansion"
} 

variable "min_size" {
  type = number
  description = "The minimum amount of instances, the floor amount of instances"
} 

variable "health_check_grace_period" {
  type = number
  description = "Grace period in seconds, between health checks"
} 

variable "desired_capacity" {
  type = number
  description = "The Goldilocks zone of capacity, this is the asg's equilibrium point"
}
variable "asg_name" {
  type = string
} 

variable "vpc_id" { 
  type = string
} 

variable "target_group_arn" {
  type = string
}
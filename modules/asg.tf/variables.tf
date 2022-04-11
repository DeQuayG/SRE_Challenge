variable "placement_strategy" {
  description = "Method with which your ASG places the scaled out EC2 Instances"
  default = "spread"
} 

variable "name_prefix" {
  type = string
  default = "asg_ec2"
} 

variable "ami" {
  description = "The 'Amazon Machine Image' that you would like to use" 
  default = "ami-0b0af3577fe5e3532"
} 

variable "instance_type" {
  description = "Category of instance example: t2.micro"
  default = "t3a.micro"
} 

variable "max_size" {
  type = number  
  description = "The maximum amount of instances, the ceiling of the asg expansion"
  default = 5
} 

variable "min_size" {
  type = number
  description = "The minimum amount of instances, the floor amount of instances"
  default = 1
} 

variable "health_check_grace_period" {
  type = number
  description = "Grace period in seconds, between health checks"
  default = 300
} 

variable "desired_capacity" {
  type = number
  description = "The Goldilocks zone of capacity, this is the asg's equilibrium point"
  default = 2
}

variable "bastion_ami" {
  description = "The 'Amazon Machine Image' for the Bastion Host"
} 

variable "bastion_instance_type" {
  description = "The tier of the hardware, t3a.medium, t2a.small, etc"
} 

variable "environment_name" {
} 

variable "subnet_ids" {
  type = map
} 

variable "vpc_security_group_ids" {
  type = map
}
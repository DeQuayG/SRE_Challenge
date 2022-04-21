variable "environment_name" {
 type = string
} 

variable "subnet_ids" {
  type = map
} 

variable "cidr_block" {
  type = list
} 

variable "vpc_security_group_ids" {
  type = list
}

variable "vpc" {
  type = list
}
### Universal Variables ##### 
variable "region" {
  description = "Default region for provider"
  type        = string
  default     = "us-east-1"
}

variable "app_name" {
  description = "Name of the web application"
  type        = string
  default     = "web-app"
}

variable "environment_name" {
  description = "Deployment environment (dev/staging/production)"
  type        = string
  default     = "dev"
}

##### Autoscaling Group Variables ##########  
variable "placement_strategy" {
  description = "Method with which your ASG places the scaled out EC2 Instances"
  default     = "spread"
}

variable "name_prefix" {
  type    = string
  default = "asg_ec2"
}

variable "ami" {
  description = "The 'Amazon Machine Image' that you would like to use"
  default     = "ami-0b0af3577fe5e3532"
}

variable "instance_type" {
  description = "Category of instance example: t2.micro"
  default     = "t3a.micro"
}

variable "max_size" {
  type        = number
  description = "The maximum amount of instances, the ceiling of the asg expansion"
  default     = 5
}

variable "min_size" {
  type        = number
  description = "The minimum amount of instances, the floor amount of instances"
  default     = 1
}

variable "health_check_grace_period" {
  type        = number
  description = "Grace period in seconds, between health checks"
  default     = 300
}

variable "desired_capacity" {
  type        = number
  description = "The Goldilocks zone of capacity, this is the asg's equilibrium point"
  default     = 2
}

variable "asg_name" {
}
######## Compute Variables ############## 

variable "bastion_ami" {
  default = "ami-0f9a92942448ac56f"
}

variable "bastion_instance_type" {
  default = "t3a.medium"
}

###### Database Variables #######  

variable "storage" {
  type    = number
  default = 10
}

variable "storage_type" {
  default = "standard"
}

variable "db_engine" {
  default = "postgresql"
}

variable "db_engine_version" {
  default = "~> 11.0.0"
}

variable "aws_db_instance_class" {
  default = "db.t3.micro"
}

variable "rds_name" {
}

variable "max_storage" {
  default     = 30
  description = "By specifying a 'max storage' variable we can enable autoscaling"
}


####### IAM Variables ########  

variable "log_role_name" {
  default = "log_watcher"
}

variable "log_watcher_policy_name" {
  default = "log_policy"
}

variable "rate" {
  description = "This variable defines how often canary is run, can be in minutes or hours"
  default     = "10"
}

variable "canary_runtime" {
  description = "This is the runtime version and language canary will use for testing"
  default     = "syn-python-selenium-1.0"
}

variable "canary_handler" {
  default = "exports.handler"
}

variable "canary_role_policy_name" {
  default = "canary_role_policy"
}

variable "canary_role_name" {
  default = "canary"
}

########### Network Variables ############ 

variable "az" {
  type    = list(any)
  default = ["us-east-1a", "us-east-1b", "us-east-1c", "us-east-1d"]
}

variable "cidr_block" {
  type = map(any)
  default = {
    "vpc"              = "10.1.0.0/16"
    "public_subnet_1"  = "10.1.0.0/24"
    "public_subnet_2"  = "10.1.1.0/24"
    "private_subnet_1" = "10.1.2.0/24"
    "private_subnet_1" = "10.1.3.0/24"
    "data_subnet_1"    = "10.1.4.0/24"
    "data_subnet_2"    = "10.1.5.0/24"
  }
}

variable "allowed_cidr_blocks" {
  type        = list(any)
  description = "External CIDR blocks that allowed to communicate with the ALB"
  default     = [""]
}

variable "hosted_domain" {
  default = "www.example.com"
} 
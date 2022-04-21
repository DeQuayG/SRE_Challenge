variable "storage" {
  type = number
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
  default = "RDS1"
} 

variable "max_storage" {
  default = 30
  description = "By specifying a 'max storage' variable we can enable autoscaling"
}
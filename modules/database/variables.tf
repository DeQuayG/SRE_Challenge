variable "storage" {
  type = number
} 

variable "storage_type" {
} 

variable "db_engine" {
  description = "The type of database, PostgreSQL for example"
}

variable "db_engine_version" {
} 

variable "aws_db_instance_class" {
} 

variable "rds_name" {
} 

variable "max_storage" {
  description = "By specifying a 'max storage' variable we can enable autoscaling"
}
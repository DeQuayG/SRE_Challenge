resource "aws_db_instance" "db_instance" {
  allocated_storage      = var.storage
  max_allocated_storage  = var.max_storage
  storage_type           = var.storage_type
  engine                 = var.db_engine
  engine_version         = var.db_engine_version
  instance_class         = var.db_instance_class
  multi_az               = false
  name                   = var.rds_name
  username               = var.db_user
  password               = var.db_pass
  skip_final_snapshot    = false
  storage_encrypted      = true
  vpc_security_group_ids = var.aws_security_group.rds_security_group.id

  tags = { 
    "Name" = "RDS"
  }
} 

## This will be used to identify which subnets the databse should be associated with
resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "${var.app_name}-${var.environment_name}-database_subnet"
  subnet_ids = [aws_subnet.data_subnet_1.id, aws_subnet.data_subnet_2.id]

  tags = {
    Name = "db subnet group"
  }
}

resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "_%@"
}
 
# Creating a AWS secret for database master account (Masteraccoundb)
 
resource "aws_secretsmanager_secret" "rds1_secret" {
   name = "rds1_db_secret"
}
 
# Creating a AWS secret versions for database master account (Masteraccoundb)
 
resource "aws_secretsmanager_secret_version" "dbs_version" {
  secret_id = aws_secretsmanager_secret.rds1_secret.id
  secret_string = <<EOF
   {
    "username": "db_admin",
    "password": "${random_password.password.result}"
   }
EOF
sensitive = true
}
 
# Importing the AWS secrets created previously using arn.
 
data "aws_secretsmanager_secret" "rds1_secret" {
  arn = aws_secretsmanager_secret.rds1_secret.arn
}
 
# Importing the AWS secret version created previously using arn.
 
data "aws_secretsmanager_secret_version" "creds" {
  secret_id = data.aws_secretsmanager_secret.rds1_secret.arn
  sensitive = true
}
 
# After importing the secrets storing into Locals
 
locals {
  db_creds = jsondecode(data.aws_secretsmanager_secret_version.creds.secret_string)
} 
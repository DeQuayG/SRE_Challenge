output "db_secret_id" {
    value = aws_secretsmanager_secret.rds1_secret.arn
    description = "ID of the DB generated secret"
    sensitive = true
}

output "secret-version" {
  value = data.aws_secretsmanager_secret.rds1_secret.id 
  sensitive = true
} 

output "db_instance_id" {
  value = aws_db_instance.db_instance.id
} 

output "bastion1_instance" {
  value = aws_instance.bastion1_instance.id
}

output "secretsmanager_secret" {
  value = aws_secretsmanager_secret.bastion1-keypair_secret.id
}

output "secretsmanager_secret_version" {
  value = aws_secretsmanager_secret_version.bastion1_version.id
} 

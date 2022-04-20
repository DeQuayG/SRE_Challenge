output "instance_id" {
  value = aws_instance.bastion1_instance.id
}

output "secretsmanager_secret" {
  value = aws_secretsmanager_secret.bastion1-keypair_secret.id
}

output "secretsmanager_secret_version" {
  value = aws_secretsmanager_secret_version.bastion1_version.id
} 

output "bastion_security_group_ids" {
  value = aws_security_group.bastion1_instance_sg.id
}
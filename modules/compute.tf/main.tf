resource "aws_instance" "bastion1_instance" {
  ami                    = var.bastion_ami
  instance_type          = "t3a.medium"
  key_name               = aws_key_pair.bastion1_instance.key_name
  subnet_id              = aws_subnet.data_subnet_1.id
  vpc_security_group_ids = var.bastion_security_group_ids
  tags                   = var.environment_name
  user_data = <<EOT
<powershell>  
New-Item 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Server' -Force
New-Item 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Client' -Force
New-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Server' -name 'Enabled' -value '1' –PropertyType 'DWORD'
New-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Server' -name 'DisabledByDefault' -value '0' –PropertyType 'DWORD'
New-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Client' -name 'Enabled' -value '1' –PropertyType 'DWORD'
New-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Client' -name 'DisabledByDefault' -value '0' –PropertyType 'DWORD'
Write-Host 'Enabling TLSv1.2'
Rename-Computer -NewName "bastion1" -Force
EOT
} 

### Bastion SSH Key ### 
resource "tls_private_key" "bastion1_instance_private_key" {
  algorithm = "RSA"
}

resource "aws_key_pair" "bastion1-keypair" {
  key_name   = "bastion1-keypair"
  public_key = tls_private_key.bastion1_instance_private_key.public_key_openssh
  tags = {
    Name = "bastion1-keypair"
  }
}

# Creates and stores ssh key used creating an EC2 instance
resource "aws_secretsmanager_secret" "bastion1-keypair_secret" {
  name = "bastion1-keypair_secret"
}

resource "aws_secretsmanager_secret_version" "bastion1_version" {
  secret_id     = aws_secretsmanager_secret.bastion1-keypair_secret.id
  secret_string = tls_private_key.bastion1_instance_private_key.private_key_pem
}

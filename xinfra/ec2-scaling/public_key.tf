# TLS 프라이빗 키 생성 (공개 키 포함)
resource "tls_private_key" "ec2_private_key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

# AWS에서 키 페어 생성
resource "aws_key_pair" "ec2_key_pair" {
  key_name   = "ec2-key_pair" # AWS에서 사용할 키 페어 이름
  public_key = tls_private_key.ec2_private_key.public_key_openssh
}

# 출력: SSH 접속에 사용할 Private Key
output "ssh_private_key_pem" {
  value       = tls_private_key.ec2_private_key.private_key_pem
  description = "Private key for SSH access"
  sensitive   = true
}
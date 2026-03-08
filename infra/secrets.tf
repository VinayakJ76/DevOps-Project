resource "aws_secretsmanager_secret" "argocd_ssh_key" {

  name = "argocd-ssh-key"

  tags = var.tags
}


resource "aws_secretsmanager_secret_version" "argocd_ssh_key_version" {

  secret_id     = aws_secretsmanager_secret.argocd_ssh_key.id
  secret_string = var.ssh_private_key

}
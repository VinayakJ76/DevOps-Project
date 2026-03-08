# ArgoCD IAM Resources
#  * IAM Policy allowing ArgoCD to read secrets from AWS Secrets Manager
#  * IAM Role assumed by the EKS cluster
#  * IAM Role Policy attachment


resource "aws_iam_policy" "argocd_secrets_policy" {

  name = "${var.project_name}-argocd-secrets-policy"

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Action = [
          "secretsmanager:GetSecretValue"
        ]

        Resource = "arn:aws:secretsmanager:${var.region}:${var.account_id}:secret:argocd-ssh-key*"
      }
    ]
  })
}


resource "aws_iam_role" "argocd_role" {

  name = "${var.project_name}-argocd-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Principal = {
          Service = "eks.amazonaws.com"
        }

        Action = "sts:AssumeRole"
      }
    ]
  })
}


resource "aws_iam_role_policy_attachment" "argocd_secrets_attachment" {

  role       = aws_iam_role.argocd_role.name
  policy_arn = aws_iam_policy.argocd_secrets_policy.arn

}
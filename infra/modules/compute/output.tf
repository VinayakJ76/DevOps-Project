# Outputs for compute module

output "worker_node_role_arn" {
  description = "IAM role ARN used by EKS worker nodes"
  value       = aws_iam_role.eks_worker_nodes_role.arn
}

output "worker_node_role_name" {
  description = "IAM role name used by EKS worker nodes"
  value       = aws_iam_role.eks_worker_nodes_role.name
}
# IAM resources for EKS worker nodes
# These roles allow Kubernetes nodes to interact with AWS services
# such as ECR, VPC networking, and EKS control plane.


resource "aws_iam_role" "eks_worker_nodes_role" {

  name = "${var.project_name}-eks-worker-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Principal = {
          Service = "ec2.amazonaws.com"
        }

        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = var.tags
}



# Attach required AWS policies for EKS worker nodes

resource "aws_iam_role_policy_attachment" "worker_node_policy" {

  role       = aws_iam_role.eks_worker_nodes_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"

}


resource "aws_iam_role_policy_attachment" "worker_node_cni_policy" {

  role       = aws_iam_role.eks_worker_nodes_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"

}


resource "aws_iam_role_policy_attachment" "worker_node_registry_policy" {

  role       = aws_iam_role.eks_worker_nodes_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"

}
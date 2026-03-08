# Compute module
# Creates launch template and managed EKS node group


resource "aws_launch_template" "eks_nodes_lt" {

  name_prefix   = "${var.cluster_name}-nodes"
  image_id      = var.ami
  instance_type = var.instance_type

  key_name = var.key_name

  vpc_security_group_ids = [
    aws_security_group.compute_sg.id
  ]

  tag_specifications {
    resource_type = "instance"

    tags = merge(
      var.tags,
      {
        Name = "${var.cluster_name}-worker-node"
      }
    )
  }
}


resource "aws_eks_node_group" "eks_nodes" {

  cluster_name    = var.cluster_name
  node_group_name = "${var.cluster_name}-node-group"

  node_role_arn = aws_iam_role.eks_worker_nodes_role.arn

  subnet_ids = var.private_subnet_ids

  scaling_config {

    desired_size = var.desired_size
    max_size     = var.max_size
    min_size     = var.min_size

  }

  launch_template {
    id      = aws_launch_template.eks_nodes_lt.id
    version = "$Latest"
  }

  instance_types = var.instance_types

  capacity_type = "ON_DEMAND"

  update_config {
    max_unavailable = 1
  }

  tags = merge(
    var.tags,
    {
      Name = "${var.cluster_name}-node-group"
    }
  )
}
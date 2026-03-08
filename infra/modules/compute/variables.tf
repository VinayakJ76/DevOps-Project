# Variables for the compute module


variable "project_name" {
  description = "Project name prefix used for AWS resources"
  type        = string
}


variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}


variable "vpc_id" {
  description = "VPC ID where compute resources will be deployed"
  type        = string
}


variable "cluster_cidr_blocks" {
  description = "CIDR blocks allowed to communicate with worker nodes"
  type        = list(string)
}


variable "ami" {
  description = "AMI ID used for worker nodes"
  type        = string
}


variable "instance_type" {
  description = "Instance type used in launch template"
  type        = string
}


variable "instance_types" {
  description = "List of instance types used by the node group"
  type        = list(string)
}


variable "key_name" {
  description = "SSH key name for EC2 instances"
  type        = string
}


variable "private_subnet_ids" {
  description = "Private subnet IDs where worker nodes will run"
  type        = list(string)
}


variable "desired_size" {
  description = "Desired number of worker nodes"
  type        = number
}


variable "min_size" {
  description = "Minimum number of worker nodes"
  type        = number
}


variable "max_size" {
  description = "Maximum number of worker nodes"
  type        = number
}


variable "tags" {
  description = "Tags applied to AWS resources"
  type        = map(string)
}
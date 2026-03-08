############################################
# Global project configuration
############################################

variable "project_name" {
  description = "Project name prefix for all infrastructure resources"
  type        = string
}

variable "cluster_name" {
  description = "Name of the Kubernetes cluster"
  type        = string
}

variable "region" {
  description = "AWS region where infrastructure will be deployed"
  type        = string
}

variable "account_id" {
  description = "AWS account ID"
  type        = string
}

variable "tags" {
  description = "Common tags applied to AWS resources"
  type        = map(string)
}


############################################
# Network module variables
############################################

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "public_subnets" {
  description = "Public subnet CIDR blocks"
  type        = list(string)
}

variable "private_subnets" {
  description = "Private subnet CIDR blocks"
  type        = list(string)
}

variable "availability_zones" {
  description = "Availability zones for subnets"
  type        = list(string)
}


############################################
# Compute module variables
############################################

variable "ami" {
  description = "AMI used for worker nodes"
  type        = string
}

variable "instance_type" {
  description = "Primary EC2 instance type"
  type        = string
}

variable "instance_types" {
  description = "Allowed EC2 instance types for node group"
  type        = list(string)
}

variable "key_name" {
  description = "SSH key name used for EC2 instances"
  type        = string
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


############################################
# ArgoCD module configuration
############################################

variable "argocd_namespace" {
  description = "Namespace where ArgoCD will be installed"
  type        = string
}

variable "argocd_release_name" {
  description = "Helm release name for ArgoCD"
  type        = string
}

variable "argocd_repository" {
  description = "Helm repository URL for ArgoCD"
  type        = string
}

variable "argocd_chart" {
  description = "ArgoCD Helm chart name"
  type        = string
}

variable "argocd_version" {
  description = "ArgoCD Helm chart version"
  type        = string
}


############################################
# GitOps repository configuration
############################################

variable "repo_url" {
  description = "Git repository URL for GitOps"
  type        = string
}

variable "repo_creds_name" {
  description = "ArgoCD repository credential name"
  type        = string
}

variable "repo_creds_repo_name" {
  description = "Repository name used in ArgoCD"
  type        = string
}

variable "repo_creds_type" {
  description = "Repository type (git)"
  type        = string
}

variable "repo_creds_project" {
  description = "ArgoCD project for the repository"
  type        = string
}


############################################
# Git SSH key secrets
############################################

variable "ssh_key_secret_id" {
  description = "AWS Secrets Manager secret containing SSH key"
  type        = string
}

variable "secrets_json" {
  description = "Map containing sensitive secret values"
  type        = map(string)
}


############################################
# Application deployment configuration
############################################

variable "app_namespace" {
  description = "Namespace where the Task Tracker app will be deployed"
  type        = string
}

variable "app_path" {
  description = "GitOps repository path for the Task Tracker app"
  type        = string
}

variable "infra_namespace" {
  description = "Namespace where infrastructure applications will be deployed"
  type        = string
}

variable "infra_path" {
  description = "GitOps repository path for infrastructure apps"
  type        = string
}


############################################
# ArgoCD sync behaviour
############################################

variable "sync_options" {
  description = "ArgoCD sync options"
  type        = list(string)
}

############################################
# Git SSH key secrets
############################################

variable "ssh_key_secret_id" {
  description = "AWS Secrets Manager secret containing SSH key"
  type        = string
}

variable "ssh_private_key" {
  description = "Private SSH key used by ArgoCD to access the GitOps repository"
  type        = string
  sensitive   = true
}

variable "secrets_json" {
  description = "Map containing sensitive secret values"
  type        = map(string)
}
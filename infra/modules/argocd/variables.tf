# ArgoCD configuration variables

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


# Git repository access configuration

variable "ssh_key_secret_id" {
  description = "AWS Secrets Manager secret containing the SSH key"
  type        = string
}

variable "repo_creds_name" {
  description = "Name of the ArgoCD repository credential"
  type        = string
}

variable "repo_creds_repo_name" {
  description = "Repository name used in ArgoCD"
  type        = string
}

variable "repo_creds_type" {
  description = "Repository type (git, helm, etc.)"
  type        = string
}

variable "repo_creds_project" {
  description = "ArgoCD project associated with the repository"
  type        = string
}

variable "repo_url" {
  description = "GitOps repository URL"
  type        = string
}


# Application configuration

variable "task_tracker_app_namespace" {
  description = "Namespace where the task-tracker application will be deployed"
  type        = string
}

variable "task_tracker_app_path" {
  description = "GitOps repository path for the task-tracker application"
  type        = string
}


# Infrastructure apps configuration

variable "infra_app_namespace" {
  description = "Namespace where infrastructure components will be deployed"
  type        = string
}

variable "infra_app_path" {
  description = "GitOps repository path for infrastructure components"
  type        = string
}


# ArgoCD sync options

variable "sync_options" {
  description = "List of ArgoCD sync options"
  type        = list(string)
}


# Secrets configuration

variable "secrets_json" {
  description = "Map containing sensitive values used by Terraform"
  type        = map(string)
}


# AWS configuration

variable "region" {
  description = "AWS region"
  type        = string
}

variable "account_id" {
  description = "AWS account ID"
  type        = string
}


# Common resource tags

variable "tags" {
  description = "Tags applied to AWS resources"
  type        = map(string)
}
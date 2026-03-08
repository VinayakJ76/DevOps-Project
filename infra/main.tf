# Root infrastructure orchestration


module "network" {

  source = "./modules/network"

  project_name       = var.project_name
  vpc_cidr           = var.vpc_cidr
  public_subnets     = var.public_subnets
  private_subnets    = var.private_subnets
  availability_zones = var.availability_zones
  tags               = var.tags
}


module "compute" {

  source = "./modules/compute"

  project_name        = var.project_name
  cluster_name        = var.cluster_name
  vpc_id              = module.network.vpc_id
  private_subnet_ids  = module.network.private_subnets
  cluster_cidr_blocks = [var.vpc_cidr]

  ami            = var.ami
  instance_type  = var.instance_type
  instance_types = var.instance_types

  key_name     = var.key_name
  desired_size = var.desired_size
  min_size     = var.min_size
  max_size     = var.max_size

  tags = var.tags
}


module "argocd" {

  source = "./modules/argocd"

  # ArgoCD configuration
  argocd_namespace     = var.argocd_namespace
  argocd_release_name  = var.argocd_release_name
  argocd_repository    = var.argocd_repository
  argocd_chart         = var.argocd_chart
  argocd_version       = var.argocd_version

  # Git repository access
  repo_url             = var.repo_url
  repo_creds_name      = var.repo_creds_name
  repo_creds_repo_name = var.repo_creds_repo_name
  repo_creds_type      = var.repo_creds_type
  repo_creds_project   = var.repo_creds_project

  # SSH key for GitOps repo
  ssh_key_secret_id    = var.ssh_key_secret_id
  secrets_json         = var.secrets_json

  # Application deployment
  task_tracker_app_namespace = var.app_namespace
  task_tracker_app_path      = var.app_path

  # Infrastructure apps
  infra_app_namespace = var.infra_namespace
  infra_app_path      = var.infra_path

  # Sync behaviour
  sync_options = var.sync_options

  # AWS
  region     = var.region
  account_id = var.account_id

  tags = var.tags
}
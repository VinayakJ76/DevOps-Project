# Infrastructure

This directory contains the Terraform infrastructure used to deploy the DevOps platform.

The infrastructure provisions:

- AWS VPC
- Subnets
- EKS cluster worker nodes
- ArgoCD
- Kubernetes namespaces
- GitOps integration

## Modules

network → VPC and subnets  
compute → EKS worker nodes  
argocd → GitOps deployment

## Deployment Flow

Terraform → AWS Infrastructure → ArgoCD → Kubernetes Applications

## Apply Infrastructure

terraform init  
terraform plan  
terraform apply

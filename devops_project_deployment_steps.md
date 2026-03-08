# Deployment Steps -- DevOps Project

This document explains the complete deployment process for the Task
Tracker DevOps platform.

------------------------------------------------------------------------

## Phase 1 --- Prerequisites

Before deployment ensure the following tools and accounts are available:

-   AWS account
-   Terraform
-   AWS CLI configured
-   kubectl
-   Helm
-   Docker
-   Git

Configure AWS CLI:

``` bash
aws configure
```

------------------------------------------------------------------------

## Phase 2 --- Provision Infrastructure (Terraform)

Navigate to the infrastructure directory:

``` bash
cd infra
```

Initialize Terraform:

``` bash
terraform init
```

Validate configuration:

``` bash
terraform validate
```

Preview infrastructure:

``` bash
terraform plan
```

Deploy infrastructure:

``` bash
terraform apply
```

Terraform provisions:

-   VPC
-   Public/private subnets
-   Security groups
-   EKS cluster
-   Worker nodes
-   IAM roles
-   ArgoCD installation

After this phase we have a **running Kubernetes cluster with ArgoCD
installed**.

------------------------------------------------------------------------

## Phase 3 --- Connect to the Kubernetes Cluster

Configure kubectl:

``` bash
aws eks update-kubeconfig --region <region> --name <cluster-name>
```

Verify nodes:

``` bash
kubectl get nodes
```

Verify ArgoCD:

``` bash
kubectl get pods -n argocd
```

------------------------------------------------------------------------

## Phase 4 --- Deploy Infrastructure Apps (GitOps)

ArgoCD monitors the **gitops directory** in the repository.

It automatically deploys:

-   cert-manager
-   ingress-nginx
-   monitoring stack
-   logging stack

These are defined under:

    gitops/infra-apps

Check running components:

``` bash
kubectl get pods -A
```

------------------------------------------------------------------------

## Phase 5 --- Deploy the Application

The application is deployed using a **Helm chart** stored in:

    gitops/task-tracker-app

ArgoCD monitors:

    gitops/task-tracker-app.yaml

This chart deploys:

-   Flask task tracker application
-   MongoDB database (Helm dependency)
-   Kubernetes service
-   Ingress
-   TLS certificate

Verify deployment:

``` bash
kubectl get pods
kubectl get svc
kubectl get ingress
```

------------------------------------------------------------------------

## Phase 6 --- CI/CD Workflow

Once the platform is running, updates follow this workflow:

1.  Developer pushes code to GitHub
2.  Jenkins pipeline runs
3.  Jenkins builds Docker image
4.  Image pushed to AWS ECR
5.  Jenkins updates Helm values in GitOps repo
6.  ArgoCD detects change
7.  Kubernetes deployment updates automatically

No manual deployment is required.

------------------------------------------------------------------------

## Final System Architecture

    AWS Infrastructure
       ↓
    EKS Cluster
       ↓
    ArgoCD GitOps
       ↓
    Platform Components
       ├─ ingress-nginx
       ├─ cert-manager
       ├─ monitoring
       └─ logging
       ↓
    Application Layer
       ├─ Task Tracker API
       └─ MongoDB

------------------------------------------------------------------------

## Accessing the Application

The application is accessed through Kubernetes Ingress:

    http://<load-balancer-ip>

TLS certificates are automatically managed by **cert-manager**.

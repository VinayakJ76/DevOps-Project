# ArgoCD Resources
#  * Kubernetes Namespace for ArgoCD
#  * Helm Release for ArgoCD
#  * Kubectl manifest for task tracker ArgoCD application
#  * Kubectl manifest for infra apps ArgoCD application


resource "kubernetes_namespace" "argocd" {
  metadata {
    name = var.argocd_namespace
  }
}


# Deploy ArgoCD using Helm
resource "helm_release" "argocd" {

  name       = "argocd"
  namespace  = var.argocd_namespace
  repository = var.argocd_repository
  chart      = var.argocd_chart
  version    = var.argocd_version

  values = [
    yamlencode({
      server = {
        service = {
          type = "ClusterIP"
        }
      }
      configs = {
        secret = {
          argocdServerAdminPassword = bcrypt(var.secrets_json["argocd-pass"])
        }
      }
    })
  ]

  depends_on = [
    kubernetes_namespace.argocd
  ]
}


# ArgoCD Application for Task Tracker
resource "kubectl_manifest" "argocd_application_task_tracker" {

  yaml_body = templatefile("${path.module}/templates/task_tracker_app.yaml.tpl", {
    namespace     = var.argocd_namespace
    repo_url      = var.repo_url
    app_namespace = var.weather_app_namespace
    app_path      = var.weather_app_path
    sync_options  = var.sync_options
  })

  depends_on = [
    helm_release.argocd
  ]
}


# ArgoCD Application for Infrastructure components
resource "kubectl_manifest" "argocd_application_infra" {

  yaml_body = templatefile("${path.module}/templates/infra_app.yaml.tpl", {
    namespace       = var.argocd_namespace
    repo_url        = var.repo_url
    infra_namespace = var.infra_app_namespace
    infra_path      = var.infra_app_path
    sync_options    = var.sync_options
  })

  depends_on = [
    helm_release.argocd
  ]
}
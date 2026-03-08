resource "kubernetes_namespace" "task_tracker" {

  metadata {
    name = var.app_namespace
  }

}

resource "kubernetes_namespace" "monitoring" {

  metadata {
    name = "monitoring"
  }

}

resource "kubernetes_namespace" "logging" {

  metadata {
    name = "logging"
  }

}
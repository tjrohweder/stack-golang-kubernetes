terraform {
  backend "local" {
    path = "./terraform.tfstate"
  }
}

provider "kubernetes" {
  config_path    = "~/.kube/config"
  config_context = "minikube"
}

resource "kubernetes_namespace" "app_namespace" {
  metadata {
    name = "applications"
  }
}

resource "kubernetes_manifest" "app_deployment" {
  for_each = {
    for idx, manifest in tolist(split("---", file("../kubernetes/app.yaml"))) : idx => yamldecode(manifest)
  }

  manifest = each.value
}

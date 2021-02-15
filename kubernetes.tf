provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  exec {
    api_version = "client.authentication.k8s.io/v1alpha1"
    command     = "aws"
    args = [
      "eks",
      "get-token",
      "--cluster-name",
      data.aws_eks_cluster.cluster.name
    ]
  }
}


resource "kubernetes_deployment" "registry-deployment" {
  metadata {
    name = "registry"
    labels = {
      App = "registry"
    }
  }

  spec {
    replicas = 2
    selector {
      match_labels = {
        App = "registry"
      }
    }
    template {
      metadata {
        labels = {
          App = "registry"
        }
      }
      spec {
        container {
          image = "registry:2.7.1"
          name  = "registry"

          port {
            container_port = 5000
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "registry-service" {
  metadata {
    name = "registry"
  }
  spec {
    selector = {
      App = kubernetes_deployment.registry-deployment.spec.0.template.0.metadata[0].labels.App
    }
    port {
      node_port   = 30201
      port        = 5000
      target_port = 5000
    }

    type = "NodePort"
  }
}
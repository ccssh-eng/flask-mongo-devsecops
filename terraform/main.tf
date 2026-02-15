terraform {
  required_providers {
    ovh = {
      source  = "ovh/ovh"
      version = ">= 0.35.0"
    }
  }
}

provider "ovh" {
  endpoint           = "ovh-eu"
  application_key    = var.ovh_application_key
  application_secret = var.ovh_application_secret
  consumer_key       = var.ovh_consumer_key
}

resource "ovh_cloud_project_kube" "k8s" {
  service_name = var.project_id
  name         = "devsecops-k8s"
  region       = var.region
#  version      = "1.28"
}

resource "ovh_cloud_project_kube_nodepool" "nodepool" {
  service_name  = var.project_id
  kube_id       = ovh_cloud_project_kube.k8s.id
  name          = "economy-pool"
  flavor_name = "b2-7"
  desired_nodes = 1
}

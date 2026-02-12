provider "ovh" {
  endpoint = "ovh-eu"
}

# Créer un cluster Kubernetes OVH
resource "ovh_cloud_project_kube" "flask_cluster" {
  name   = "flask-mongo-devsecops"
  region = "GRA5" # exemple
  node_count = 2
  node_flavor = "b2-7"
  kube_version = "1.27"
}

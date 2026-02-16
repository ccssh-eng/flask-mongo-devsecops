locals {
  ttl_hours = 48
}

resource "null_resource" "ttl_marker" {
  provisioner "local-exec" {
    command = "date +%s > cluster_start.txt"
  }
}

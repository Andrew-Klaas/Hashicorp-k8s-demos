terraform {
  required_version = ">= 0.11.0"
}

provider "google" {
  //See the following to configure crednetials for the provider:
  //https://registry.terraform.io/providers/hashicorp/google/latest/docs/guides/getting_started#configuring-the-provider
  project     = var.gcp_project
  region      = var.gcp_region
}

resource "google_container_cluster" "k8sexample" {
  name               = var.cluster_name
  description        = "k8s demo cluster"
  location               = var.gcp_zone
  initial_node_count = var.initial_node_count
  enable_legacy_abac = "true"

  master_auth {
    username = var.master_username
    password = var.master_password
  }

  node_config {
    machine_type = var.node_machine_type
    disk_size_gb = var.node_disk_size
    oauth_scopes = [
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring"
    ]
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
}

provider "google-beta" {
  project = var.project_id
  region = "us-central1"
  zone   = "us-central1-a"
}

resource "google_project_service" "compute_api" {
  service = "compute.googleapis.com"
}
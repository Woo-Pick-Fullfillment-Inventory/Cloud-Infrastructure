resource "google_artifact_registry_repository" "woopick-gcr-repo" {
  location      = var.region
  repository_id = "woopick-registry"
  description   = "docker repository"
  format        = "DOCKER"

  docker_config {
    immutable_tags = true
  }
}
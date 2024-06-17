// creating artifact registry repo over UI
// we dont use terraform beta 
// no clean up policies allowed in this version

// todo: add provider beta later
// https://registry.terraform.io/providers/hashicorp/google/latest/docs/guides/provider_versions
// todo: adjust the cleanup policies

resource "google_artifact_registry_repository" "backend_artifact_registry_repository_eu" {
  project                = var.project_id
  provider               = google-beta
  location               = var.region
  repository_id          = "backend-registry-eu"
  format                 = "DOCKER"
  cleanup_policy_dry_run = false
  cleanup_policies {
    id     = "delete-prerelease"
    action = "DELETE"
    condition {
      tag_state    = "TAGGED"
      tag_prefixes = ["alpha", "v0"]
      older_than   = "2592000s"
    }
  }
  cleanup_policies {
    id     = "keep-tagged-release"
    action = "KEEP"
    condition {
      tag_state             = "TAGGED"
      tag_prefixes          = ["release"]
      package_name_prefixes = ["webapp", "mobile"]
    }
  }
  cleanup_policies {
    id     = "keep-minimum-versions"
    action = "KEEP"
    most_recent_versions {
      package_name_prefixes = ["webapp", "mobile", "sandbox"]
      keep_count            = 5
    }
  }
}

resource "google_artifact_registry_repository" "backend_artifact_registry_repository_us" {
  project                = var.project_id
  provider               = google-beta
  location               = var.secondary_region
  repository_id          = "backend-registry-us"
  format                 = "DOCKER"
  cleanup_policy_dry_run = false
  cleanup_policies {
    id     = "delete-prerelease"
    action = "DELETE"
    condition {
      tag_state    = "TAGGED"
      tag_prefixes = ["alpha", "v0"]
      older_than   = "2592000s"
    }
  }
  cleanup_policies {
    id     = "keep-tagged-release"
    action = "KEEP"
    condition {
      tag_state             = "TAGGED"
      tag_prefixes          = ["release"]
      package_name_prefixes = ["webapp", "mobile"]
    }
  }
  cleanup_policies {
    id     = "keep-minimum-versions"
    action = "KEEP"
    most_recent_versions {
      package_name_prefixes = ["webapp", "mobile", "sandbox"]
      keep_count            = 5
    }
  }
}

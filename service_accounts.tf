resource "google_service_account" "github_service_account" {
  account_id   = "github-actions-woopick"
  display_name = "github-actions-woopick"
}

variable "iam_roles" {
  type = map(string)
  default = {
    gcr_writer           = "roles/artifactregistry.writer",
    artifact_writer      = "roles/artifactregistry.repoAdmin",
    storage_admin        = "roles/storage.admin",
    wif_user             = "roles/iam.workloadIdentityUser",
    cloud_sql_admin      = "roles/cloudsql.admin",
    service_account_user = "roles/iam.serviceAccountUser",
    firestore_user       = "roles/datastore.user",
  }
}

resource "google_project_iam_member" "iam_members" {
  for_each = var.iam_roles

  project = var.project_id
  role    = each.value
  member  = "serviceAccount:${google_service_account.github_service_account.email}"
}

resource "google_service_account_iam_binding" "github_sa_iam_binding_wif" {
  service_account_id = google_service_account.github_service_account.name
  role               = "roles/iam.workloadIdentityUser"
  members = [
    "principalSet://iam.googleapis.com/projects/${var.project_number}/locations/global/workloadIdentityPools/${google_iam_workload_identity_pool.woopick_tfc_identity_pool.workload_identity_pool_id}/attribute.repository/Woo-Pick-Fullfillment-Inventory/Backend-Woo-Inventory"
  ]
}

resource "google_service_account" "backend_cloudrun_service_account" {
  account_id   = "backend-woopick-cloudrun"
  display_name = "backend-woopick-cloudrun"
}

/* resource "google_service_account_iam_binding" "cloudrun_backend_sa_iam_binding" {
  service_account_id = google_service_account.backend_cloudrun_service_account.name
  role               = "roles/spanner.admin"
  members = [
  ]
} */
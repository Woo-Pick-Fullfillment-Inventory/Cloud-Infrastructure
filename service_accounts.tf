resource "google_service_account" "github_service_account" {
  account_id   = "github-actions-woopick"
  display_name = "github-actions-woopick"
}

variable "iam_roles" {
  type = map(string)
  default = {
    gcr_writer      = "roles/artifactregistry.writer",
    storage_admin   = "roles/storage.admin",
    wif_user        = "roles/iam.workloadIdentityUser",
    cloud_sql_admin = "roles/cloudsql.admin",
  }
}

resource "google_project_iam_member" "iam_members" {
  for_each = var.iam_roles

  project = var.project_id
  role    = each.value
  member  = "serviceAccount:${google_service_account.github_service_account.email}"
}

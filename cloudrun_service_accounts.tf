resource "google_service_account" "backend_cloudrun_service_account" {
  account_id   = "backend-woopick-cloudrun"
  display_name = "backend-woopick-cloudrun"
}

variable "iam_roles_backend_cloudrun_sa" {
  type = map(string)
  default = {
    datastore_user          = "roles/datastore.user"
    cloud_run_admin         = "roles/run.admin"
    secret_manager_accessor = "roles/secretmanager.secretAccessor"
    service_account_user    = "roles/iam.serviceAccountUser"
    storage_object_user     = "roles/storage.objectUser"
  }
}

resource "google_project_iam_member" "backend_cloudrun_iam_members" {
  for_each = var.iam_roles_backend_cloudrun_sa

  project = var.project_id
  role    = each.value
  member  = "serviceAccount:${google_service_account.backend_cloudrun_service_account.email}"
}

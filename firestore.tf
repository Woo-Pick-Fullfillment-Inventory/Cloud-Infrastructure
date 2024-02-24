resource "google_firestore_database" "woo_pick_firestore_database" {
  project                           = var.project_id
  name                              = "woo-pick-inventory-firestore"
  location_id                       = "eur3"
  type                              = "FIRESTORE_NATIVE"
  //concurrency_mode                  = "OPTIMISTIC"
  app_engine_integration_mode       = "DISABLED"
  point_in_time_recovery_enablement = "POINT_IN_TIME_RECOVERY_ENABLED"
  delete_protection_state           = "DELETE_PROTECTION_ENABLED"
  //deletion_policy                   = "DELETE"
}

resource "google_firestore_backup_schedule" "woo_pick_firestore_daily_backup" {
  project  = var.project_id
  database = google_firestore_database.woo_pick_firestore_database.name

  retention = "604800s" // 7 days (maximum possible value for daily backups)

  daily_recurrence {}
}

resource "google_firebaserules_ruleset" "secondary" {
  source {
    files {
      content     = "service cloud.firestore {match /databases/{database}/documents { match /{document=**} { allow read, write: if true; } } }"
      name        = "firestore.rules"
      fingerprint = ""
    }

    language = ""
  }
  project = var.project_id
}
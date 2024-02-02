resource "google_firestore_database" "woo_pick_firestore_database" {
  project                           = var.project_id
  name                              = "woo-pick-inventory-firestore"
  location_id                       = "eur3"
  type                              = "FIRESTORE_NATIVE"
  //concurrency_mode                  = "OPTIMISTIC"
  app_engine_integration_mode       = "DISABLED"
  point_in_time_recovery_enablement = "POINT_IN_TIME_RECOVERY_ENABLED"
  delete_protection_state           = "DELETE_PROTECTION_ENABLED"
}

resource "google_firestore_backup_schedule" "woo_pick_firestore_daily_backup" {
  project  = "my-project-name"
  database = google_firestore_database.woo_pick_firestore_database.name

  retention = "604800s" // 7 days (maximum possible value for daily backups)

  daily_recurrence {}
}
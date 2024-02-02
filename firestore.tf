resource "google_firestore_database" "firestore-database" {
  project                           = var.project_id
  name                              = "woo-pick-inventory-firestore"
  location_id                       = "eur3"
  type                              = "FIRESTORE_NATIVE"
  //concurrency_mode                  = "OPTIMISTIC"
  app_engine_integration_mode       = "DISABLED"
  point_in_time_recovery_enablement = "POINT_IN_TIME_RECOVERY_ENABLED"
  delete_protection_state           = "DELETE_PROTECTION_ENABLED"
  deletion_policy                   = "ABANDON"
}
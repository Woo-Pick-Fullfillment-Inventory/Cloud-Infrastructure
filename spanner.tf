resource "google_spanner_instance" "woo_pick_inventory_spanner" {
  config       = "regional-europe-west3"
  display_name = "woo_pick_inventory_spanner"
  processing_units    = 100
}
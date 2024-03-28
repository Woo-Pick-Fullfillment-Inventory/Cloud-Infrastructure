resource "google_storage_bucket" "woo_pick_products_images" {
  name          = "woo-pick-products-images"
  location      = "EU"
  force_destroy = false
  storage_class = "STANDARD"
  autoclass {
    enabled = true
  }
  versioning {
    enabled = true
  }
  public_access_prevention = "inherited"
}

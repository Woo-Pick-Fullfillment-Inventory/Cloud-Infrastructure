resource "google_compute_global_address" "lb_default" {
  provider = google-beta
  name     = "woopick-backend-lb-ip"

  # Use an explicit depends_on clause to wait until API is enabled
  depends_on = [
    google_project_service.compute_api
  ]
}
output "load_balancer_ip_addr" {
  value = google_compute_global_address.lb_default.address
}

resource "google_compute_region_network_endpoint_group" "cloudrun_neg_eu" {
  name                  = "woopick-backend-cloudrun-neg-eu"
  region                = "eu-west3"
  network_endpoint_type = "SERVERLESS"
  cloud_run {
    service = "woopick-backend-eu"
  }
}

resource "google_compute_region_network_endpoint_group" "cloudrun_neg_us" {
  name                  = "woopick-backend-cloudrun-neg-us"
  region                = "us-central1"
  network_endpoint_type = "SERVERLESS"
  cloud_run {
    service = "woopick-backend-us"
  }
}
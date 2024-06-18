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
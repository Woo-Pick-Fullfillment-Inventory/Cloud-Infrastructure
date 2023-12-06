resource "google_compute_network" "sql_vpc_network" {
  project                 = var.project_id
  name                    = "backend-vpc-network"
  auto_create_subnetworks = false
  mtu                     = 1460
}

resource "google_compute_subnetwork" "sql_subnet" {
  name          = "sql-subnet"
  region        = var.region
  network       = google_compute_network.sql_vpc_network.name
  ip_cidr_range = "10.10.10.0/28"
  project       = var.project_id
}
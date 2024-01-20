// add auto-scailing later on
resource "google_spanner_instance" "woo_pick_inventory_spanner" {
  config           = "regional-europe-west3"
  display_name     = "woo_pick_inventory_spanner"
  processing_units = 100
}

resource "google_spanner_database" "database" {
  instance = google_spanner_instance.woo_pick_inventory_spanner.name
  name     = "woo_app_users"
  ddl = [
    <<-EOF
    CREATE TABLE app_users (
      app_user_id STRING(255) NOT NULL,
      app_email STRING(255) NOT NULL,
      app_username STRING(255) NOT NULL,
      app_password STRING(255) NOT NULL,
      app_url STRING(255) NOT NULL,
      authenticated BOOL NOT NULL
    ) PRIMARY KEY (app_user_id)
  EOF
    , <<-EOF
    CREATE UNIQUE INDEX EmailUniqueIndex ON app_users (app_email)
  EOF
    , <<-EOF
    CREATE UNIQUE INDEX UsernameUniqueIndex ON app_users (app_username)
  EOF
    , <<-EOF
    CREATE TABLE app_users_to_woo_users (
        app_user_id STRING(255) NOT NULL,
        woo_user_id STRING(255) NOT NULL,
        CONSTRAINT fk_app_user_id FOREIGN KEY (app_user_id) REFERENCES app_users (app_user_id),
        CONSTRAINT fk_woo_user_id FOREIGN KEY (woo_user_id) REFERENCES woo_users (woo_user_id)
    ) PRIMARY KEY (app_user_id, woo_user_id)
  EOF
    , <<-EOF
    CREATE TABLE woo_users (
        woo_user_id STRING(255) NOT NULL,
        woo_token STRING(255) NOT NULL,
        woo_secret STRING(255) NOT NULL
    ) PRIMARY KEY (woo_user_id)
  EOF
  ]
  deletion_protection = true
}
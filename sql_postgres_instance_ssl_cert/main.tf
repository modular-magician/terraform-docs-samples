# [START cloud_sql_postgres_instance_require_ssl]
resource "google_sql_database_instance" "default" {
  name             = ""
  region           = "asia-northeast1"
  database_version = "postgres_14"
  settings {
    tier              = "db-custom-2-7680"
    ip_configuration {
      require_ssl = "true"
    }
  }
  deletion_protection = "true"
}
# [END cloud_sql_postgres_instance_require_ssl]

# [START cloud_sql_postgres_instance_ssl_cert]
resource "google_sql_ssl_cert" "client_cert" {
  common_name = "client-name"
  instance    = google_sql_database_instance.default.name
}
# [END cloud_sql_postgres_instance_ssl_cert]

# [START cloud_sql_sqlserver_instance_require_ssl]
resource "google_sql_database_instance" "default" {
  name             = "sqlserver-instance"
  region           = "asia-northeast1"
  database_version = "SQLSERVER_2019_STANDARD"
  root_password = "INSERT-PASSWORD-HERE"
  settings {
    tier              = "db-custom-2-7680"
    ip_configuration {
      require_ssl = "true"
    }
  }
  deletion_protection = "true"
}
# [END cloud_sql_sqlserver_instance_require_ssl]

# [START cloud_sql_sqlserver_instance_ssl_cert]
resource "google_sql_ssl_cert" "client_cert" {
  common_name = "client-name"
  instance    = google_sql_database_instance.default.name
}
# [END cloud_sql_sqlserver_instance_ssl_cert]

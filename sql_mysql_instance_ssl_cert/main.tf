# [START cloud_sql_mysql_instance_require_ssl]
resource "google_sql_database_instance" "default" {
  name             = "sql_mysql_instance_ssl_cert"
  region           = "asia-northeast1"
  database_version = "MYSQL_8_0"
  settings {
    tier              = "db-f1-micro"
    ip_configuration {
      require_ssl = "true"
    }
  }
  deletion_protection = "true"
}
# [END cloud_sql_mysql_instance_require_ssl]

# [START cloud_sql_mysql_instance_ssl_cert]
resource "google_sql_ssl_cert" "client_cert" {
  common_name = "client-name"
  instance    = google_sql_database_instance.default.name
}
# [END cloud_sql_mysql_instance_ssl_cert]

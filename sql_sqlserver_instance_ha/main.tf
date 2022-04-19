# [START cloud_sql_sqlserver_instance_ha]
resource "google_sql_database_instance" "default" {
  name             = "sqlserver-instance-ha"
  region           = "us-central1"
  database_version = "SQLSERVER_2019_STANDARD"
  root_password = "INSERT-PASSWORD-HERE"
  settings {
    tier              = "db-custom-2-7680"
    availability_type = "REGIONAL"
    backup_configuration {
      enabled            = true
      binary_log_enabled = true
      start_time         = "20:55"
    }
  }
  deletion_protection =  "true"
}
# [END cloud_sql_sqlserver_instance_ha]

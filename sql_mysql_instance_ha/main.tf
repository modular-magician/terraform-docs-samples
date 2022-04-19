# [START cloud_sql_mysql_instance_ha]
resource "google_sql_database_instance" "instance" {
  name             = "mysql-instance-ha"
  region           = "asia-northeast1"
  database_version = "MYSQL_8_0"
  settings {
    tier              = "db-f1-micro"
    availability_type = "REGIONAL"
    backup_configuration {
      enabled                        = true
      binary_log_enabled             = true
      start_time                     = "20:55"
    }
  }
  deletion_protection =  "true"
}
# [END cloud_sql_mysql_instance_ha]

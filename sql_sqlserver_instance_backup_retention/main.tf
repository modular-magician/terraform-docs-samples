# [START cloud_sql_sqlserver_instance_backup_retention]
resource "google_sql_database_instance" "default" {
  name             = ""
  region           = "us-central1"
  database_version = "SQLSERVER_2017_STANDARD"
  root_password = "INSERT-PASSWORD-HERE"
  settings {
    tier = "db-custom-2-7680"
    backup_configuration {
      enabled                        = true
      backup_retention_settings {
        retained_backups               = 365
        retention_unit                 = "COUNT"
      }
    }
  }
  deletion_protection =  "true"
}
# [START cloud_sql_sqlserver_instance_backup_retention]

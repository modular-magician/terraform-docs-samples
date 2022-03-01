# [START cloud_sql_postgres_instance_backup_retention]
resource "google_sql_database_instance" "instance" {
  name             = "postgres-instance-backup"
  region           = "us-central1"
  database_version = "POSTGRES_12"
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
  deletion_protection=false
}
# [START cloud_sql_postgres_instance_backup_retention]

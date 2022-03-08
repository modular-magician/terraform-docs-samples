# [START cloud_sql_mysql_instance_backup_retention]
resource "google_sql_database_instance" "instance" {
  name             = "mysql-instance-backup"
  region           = "asia-northeast1"
  database_version = "MYSQL_5_7"
  settings {
    tier = "db-f1-micro"
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
# [START cloud_sql_mysql_instance_backup_retention]

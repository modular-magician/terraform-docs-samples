# [START cloud_sql_mysql_instance_80_db_n1_s2]
resource "google_sql_database_instance" "instance" {
  name             = "mysql-instance"
  region           = "us-central1"
  database_version = "MYSQL_8_0"
  settings {
    tier = "db-n1-standard-2"
  }
  deletion_protection =  "true"
}
# [END cloud_sql_mysql_instance_80_db_n1_s2]

# [START cloud_sql_mysql_instance_user]
resource "google_sql_user" "default" {
  name     = "users-name"
  instance = google_sql_database_instance.instance.name
  host     = "example.com"
  password = "changeme"
}
# [END cloud_sql_mysql_instance_user]

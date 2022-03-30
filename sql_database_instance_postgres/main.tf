# [START cloud_sql_postgres_instance_80_db_n1_s2]
resource "google_sql_database_instance" "instance" {
  name             = "postgres-instance"
  region           = "us-central1"
  database_version = "POSTGRES_12"
  settings {
    tier = "db-custom-2-7680"
  }
  deletion_protection =  "true"
}
# [END cloud_sql_postgres_instance_80_db_n1_s2]

# [START cloud_sql_postgres_instance_user]
resource "google_sql_user" "default" {
  name     = "users-name"
  instance = google_sql_database_instance.instance.name
  password = "changeme"
}
# [END cloud_sql_postgres_instance_user]

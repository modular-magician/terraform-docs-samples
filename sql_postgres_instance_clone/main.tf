# [START cloud_sql_postgres_instance_clone]
resource "google_sql_database_instance" "default" {
  name             = ""
  region           = "us-central1"
  database_version = "POSTGRES_12"
  clone {
    source_instance_name = ""
  }
  deletion_protection =  "true"
}
# [END cloud_sql_postgres_instance_clone]

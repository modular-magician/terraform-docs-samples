# [START cloud_sql_sqlserver_instance_clone]
resource "google_sql_database_instance" "default" {
  name             = ""
  region           = "us-central1"
  database_version = "SQLSERVER_2017_STANDARD"
  root_password = "INSERT-PASSWORD-HERE"
  clone {
    source_instance_name = ""
  }
  deletion_protection =  "true"
}
# [END cloud_sql_sqlserver_instance_clone]

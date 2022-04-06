# [START cloud_sql_postgres_instance_primary]
resource "google_sql_database_instance" "primary" {
  name             = "postgres-primary-instance-name"
  region           = "europe-west4"
  database_version = "POSTGRES_12"
  settings {
    tier               = "db-custom-2-7680"
    backup_configuration {
      enabled            = "true"
    }
  }
  deletion_protection =  "true"
}
# [END cloud_sql_postgres_instance_primary]

# [START cloud_sql_postgres_instance_replica]
resource "google_sql_database_instance" "read_replica" {
  name                 = "postgres-replica-instance-name"
  master_instance_name = google_sql_database_instance.primary.name
  region               = "europe-west4"
  database_version     = "POSTGRES_12"

  replica_configuration {
    failover_target = false
  }

  settings {
    tier              = "db-custom-2-7680"
    availability_type = "ZONAL"
    disk_size         = "100"
  }
  deletion_protection =  "true"
}
# [END cloud_sql_postgres_instance_replica]

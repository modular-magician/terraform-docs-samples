# Example of how to deploy a Cloud Run application with system packages

# [START cloudrun_system_packages]
resource "google_cloud_run_service" "default" {
  name     = "graphviz-example"
  location = "us-central1"

  template {
    spec {
      containers {
        # Replace with the URL of your graphviz image
        #   gcr.io/<YOUR_GCP_PROJECT_ID>/graphviz
        image = "gcr.io/cloudrun/hello"
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }
}
# [END cloudrun_system_packages]

# [START cloudrun_system_packages_allow_unauthenticated]
# Make Cloud Run service publicly accessible
resource "google_cloud_run_service_iam_member" "allow_unauthenticated" {
  service  = google_cloud_run_service.default.name
  location = google_cloud_run_service.default.location
  role     = "roles/run.invoker"
  member   = "allUsers"
}
# [END cloudrun_system_packages_allow_unauthenticated]

# [START cloudrun_vpc_access_connector]
resource "google_cloud_run_service" "default" {
  name     = "cloudrun-srv"
  location = "us-central1"

  template {
    spec {
      containers {
        image = "gcr.io/cloudrun/hello"
      }
    }
    metadata {
      annotations = {
        # limit scale up to prevent any cost blow outs!
        "autoscaling.knative.dev/maxScale" = "5"
        # Set minimum if do not require scale to zero
        # "autoscaling.knative.dev/minScale" = "1"
        # use the VPC Connector above
        "run.googleapis.com/vpc-access-connector" = "central-serverless"
        # all egress from the service should go through the VPC Connector
        "run.googleapis.com/vpc-access-egress" = "all"
      }
    }
  }
}

resource "google_cloud_run_service_iam_member" "public-access" {
  location = google_cloud_run_service.default.location
  service  = google_cloud_run_service.default.name
  role     = "roles/run.invoker"
  member   = "allUsers"
}
# [END cloudrun_vpc_access_connector]

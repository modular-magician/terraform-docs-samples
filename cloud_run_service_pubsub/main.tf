# [START cloud_run_service_pubsub_service]
resource "google_cloud_run_service" "default" {
    name     = "cloud_run_service_name"
    location = "us-central1"

    template {
      spec {
            containers {
                image = "gcr.io/cloudrun/hello"
            }
      }
    }
    traffic {
      percent         = 100
      latest_revision = true
    }
}
# [END cloud_run_service_pubsub_service]

# [START cloud_run_service_pubsub_sa]
resource "google_service_account" "sa" {
  account_id   = "cloud-run-pubsub-invoker"
  display_name = "Cloud Run Pub/Sub Invoker"
}
# [START cloud_run_service_pubsub_sa]

locals {
  cloud_run_url = google_cloud_run_service.default.status[0].url
  pubsub_sa= google_service_account.sa.email
}

# [START cloud_run_service_pubsub_run_invoke_permissions]
resource "google_cloud_run_service_iam_binding" "binding" {
  location = google_cloud_run_service.default.location
  project = google_cloud_run_service.default.project
  service = google_cloud_run_service.default.name
  role = "roles/run.invoker"
  members = ["serviceAccount:${local.pubsub_sa}"]
}
# [END cloud_run_service_pubsub_run_invoke_permissions]

# [START cloud_run_service_pubsub_token_permissions]
resource "google_project_iam_binding" "project" {
  project = "my-project-name"
  role    = "roles/iam.serviceAccountTokenCreator"
  members = ["serviceAccount:${local.pubsub_sa}"]
}
# [END cloud_run_service_pubsub_token_permissions]

# [START cloud_run_service_pubsub_topic]
resource "google_pubsub_topic" "topic" {
  name = "pubsub_topic"
}
# [END cloud_run_service_pubsub_topic]

# [START cloud_run_service_pubsub_sub]
resource "google_pubsub_subscription" "subscription" {
  name  = "pubsub_subscription"
  topic = google_pubsub_topic.topic.name

  push_config {
    push_endpoint = "${local.cloud_run_url}"
    oidc_token {
      service_account_email = "${local.pubsub_sa}"
    }
    attributes = {
      x-goog-version = "v1"
    }
  }
}
# [END cloud_run_service_pubsub_sub]

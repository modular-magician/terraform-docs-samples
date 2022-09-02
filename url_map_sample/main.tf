# [START cloudloadbalancing_url_map]

# [START cloudloadbalancing_url_map_instance_health_check]
resource "google_compute_region_health_check" "health-check" {
  check_interval_sec = 5
  healthy_threshold  = 2

  http_health_check {
    port         = 26
    proxy_header = "NONE"
    request_path = "/"
  }

  name                = "health-check"
  region              = "us-central1"
  timeout_sec         = 5
  unhealthy_threshold = 2
}
# [END cloudloadbalancing_url_map_instance_health_check]

# [START cloudloadbalancing_url_map_instance_region_backend_service]
resource "google_compute_region_backend_service" "backend-service" {
  connection_draining_timeout_sec = 300
  health_checks                   = [google_compute_region_health_check.health-check.id]
  load_balancing_scheme           = "EXTERNAL_MANAGED"
  locality_lb_policy              = "ROUND_ROBIN"
  name                            = "backend-service"
  port_name                       = "http"
  protocol                        = "HTTP"
  region                          = "us-central1"
  session_affinity                = "NONE"
  timeout_sec                     = 30
}
# [END cloudloadbalancing_url_map_instance_region_backend_service]

# [START cloudloadbalancing_url_map_instance]
resource "google_compute_region_url_map" "url_map" {
  default_service = google_compute_region_backend_service.backend-service.id
  name            = "url-map"
  region          = "us-central1"
}
# [END cloudloadbalancing_url_map_instance]

# [END cloudloadbalancing_url_map]

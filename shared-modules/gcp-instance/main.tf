

locals {
  hostname      = var.hostname == "" ? "default" : var.hostname
  num_instances = length(var.static_ips) == 0 ? var.num_instances : length(var.static_ips)

  static_ips = concat(var.static_ips, ["NOT_AN_IP"])
  project_id = length(regexall("/projects/([^/]*)", var.instance_template)) > 0 ? flatten(regexall("/projects/([^/]*)", var.instance_template))[0] : null
}

###############
# Data Sources
###############

data "google_compute_zones" "available" {
  project = local.project_id
  region  = var.region
}

#############
# Instances
#############


resource "google_compute_instance_from_template" "compute_instance" {
  provider = google
  count    = local.num_instances
  name     = "${local.hostname}-${format("%03d", count.index + 1)}"
  project  = local.project_id
  zone     = data.google_compute_zones.available.names[count.index % length(data.google_compute_zones.available.names)]
  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = var.email
    scopes = ["cloud-platform"]
  }
  network_interface {
    subnetwork         = var.subnetwork
    subnetwork_project = var.project_id
    network_ip         = length(var.static_ips) == 0 ? "" : element(local.static_ips, count.index)
    dynamic "access_config" {
      for_each = var.access_config
      content {
        nat_ip       = access_config.value.nat_ip
        network_tier = access_config.value.network_tier
      }
    }
  }

  source_instance_template = var.instance_template
}



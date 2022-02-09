terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
 
    }
  }
}

provider "google" {
  region = var.region
}

resource "google_redis_instance" "cache" {
  name           = var.redis_name
  tier           = var.tier
  memory_size_gb = var.mem_size
  project        = var.project_id
  auth_enabled           = true

  location_id             = var.location_id


  authorized_network = var.authorized_network

  redis_version     =  var.redis_version
  display_name      = var.display_name

}
// This example assumes this network already exists.
// The API creates a tenant network per network authorized for a
// Redis instance and that network is not deleted when the user-created
// network (authorized_network) is deleted, so this prevents issues
// with tenant network quota.
// If this network hasn't been created and you are using this example in your
// config, add an additional network resource or change
// this from "data"to "resource"

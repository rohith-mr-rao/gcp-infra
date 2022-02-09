module "postgres" {
  source           = "../../../shared-modules/terraform-google-cloud-postgres-db"
  project_id       = var.project_id
  region           = var.region
  db_name          = "${var.prefix}-postgres"
  database_version = var.database_version
  tier             = var.cloudsql_tier
  zone             = var.cloudsql_zone
  #network_name = module.vpc.network_name
  network_name = "projects/${var.project_id}/global/networks/${module.vpc.network_name}"
  deletion_protection = false
  # Wait for the vpc connection to complete
  dependencies = [module.vpc.network_name]
  custom_labels = {
    env  = var.environment
  }
}

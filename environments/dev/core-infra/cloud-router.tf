module "cloud_router" {
  source = "../../../shared-modules/terraform-google-cloud-router"

  name       = "${var.prefix}-router"
  project    = var.project_id
  region     = var.region
  network    = module.vpc.network_name
  depends_on = [module.vpc]
}
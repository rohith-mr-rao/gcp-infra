module "cloud-nat" {
  source     = "../../../shared-modules/terraform-google-cloud-nat"
  name       = "${var.prefix}-nat"
  project_id = var.project_id
  region     = var.region
  router     = module.cloud_router.router.name
  depends_on = [module.cloud_router]
}
module "bucket" {
  source = "../../../shared-modules/terraform-google-cloud-storage"

  name       = "${var.prefix}-documents"
  project_id = var.project_id
  location   = var.region
}
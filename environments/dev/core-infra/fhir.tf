module "healthcare" {
  source  = "../../../shared-modules/terraform-google-cloud-healthcare"

  project  = var.project_id
  name     = "${var.prefix}-dataset"
  location = var.region
  fhir_stores = [{
    name         = var.fhir_store_name1
    enable_update_create = true
    version      = "R4"
  },{
    name         = var.fhir_store_name2
    enable_update_create = true
    version      = "R4"
  }]

}

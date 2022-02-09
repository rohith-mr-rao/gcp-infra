module "google_cloudbuild_trigger_backend" {
  source               = "../../../shared-modules/terraform-google-cloud-build"
  name                 = "${var.prefix}-dtr"
  repo_owner           = var.repo_owner
  repo_name            = "Gd-backend"
  branch_name          = var.branch_name
  project              = var.project_id
  filename             = var.filename
  _VAR1                = var._VAR1
  v1                   = var.v1
  _VAR2                = var._VAR2
  v2                   = "./GD-helmcharts/dev/gd-backend-charts/"
  _VAR3                = var._VAR3
  v3                   = var.v3
  _VAR4                = var._VAR4
  v4                   = var.v4
  _SONAR_INSTANCE      = var._SONAR_INSTANCE
  _PROJECT             = var._PROJECT
  _SONAR_INSTANCE_ZONE = var._SONAR_INSTANCE_ZONE
  sonar_instance_name  = var.sonar_instance
  project_name         = var.project_id
  sonar_instance_zone  = var.sonar_zone
}
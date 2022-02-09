resource "google_cloudbuild_trigger" "cloud-build" {
  name     = var.name
  github {
    owner = var.repo_owner
    name  = var.repo_name
    push {
      branch = var.branch_name
    }
  }
  project  = var.project
  filename = var.filename
  substitutions = {
    "${var._VAR1}"                = var.v1
    "${var._VAR2}"                = var.v2
    "${var._VAR3}"                = var.v3
    "${var._VAR4}"                = var.v4
    "${var._SONAR_INSTANCE}"      = var.sonar_instance_name
    "${var._PROJECT}"             = var.project_name
    "${var._SONAR_INSTANCE_ZONE}" = var.sonar_instance_zone

}
}

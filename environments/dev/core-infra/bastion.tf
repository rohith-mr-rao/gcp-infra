module "instance_template" {
  source      = "../../../shared-modules/gcp-instance-template"
  network     = "${var.prefix}-vpc"
  name_prefix = "${var.prefix}-bastion-template"
  labels = {
    env  = var.environment,
    type = "management-server"
  }
  region             = var.region
  project_id         = var.project_id
  subnetwork         = "${var.prefix}-public-subnet"
  tags               = ["${var.prefix}-bastion-template"]
  subnetwork_project = var.project_id
  depends_on         = [module.vpc]
}

module "bastion_instance" {
  project_id        = var.project_id
  source            = "../../../shared-modules/gcp-instance"
  region            = var.region
  subnetwork        = "${var.prefix}-public-subnet"
  num_instances     = var.num_management_instances
  hostname          = "${var.prefix}-bastion-server"
  instance_template = module.instance_template.self_link
  email             = var.sa_bastion
}
data "google_client_config" "default" {}

provider "kubernetes" {
  load_config_file = true
  #host                   = "https://${module.gke.endpoint}"
  #token                  = data.google_client_config.default.access_token
  #cluster_ca_certificate = base64decode(module.gke.ca_certificate)
}

data "google_compute_subnetwork" "subnetwork" {
  name    = local.internal_subnet
  project = var.project_id
  region  = var.region
}

module "gke" {
  source     = "../../../shared-modules/terraform-google-kubernetes-engine"
  project_id = var.project_id
  name       = "${var.prefix}-gke-cluster-1"
  regional   = true
  region     = var.region
  zones      = var.zones
  network    = "${var.prefix}-vpc"
  #subnetwork               = data.google_compute_subnetwork.subnetwork.self_link
  subnetwork                = local.internal_subnet
  ip_range_pods             = "${var.prefix}-private-subnet-pod"
  ip_range_services         = "${var.prefix}-private-subnet-service"
  create_service_account    = false
  enable_private_endpoint   = true
  enable_private_nodes      = true
  master_ipv4_cidr_block    = var.master_ipv4_cidr_block
  default_max_pods_per_node = var.default_max_pods_per_node
  istio                     = var.istio_enabled
  depends_on                = [module.vpc]
  remove_default_node_pool  = true
  initial_node_count        = 1

  cluster_resource_labels = {
    name = "${var.prefix}-gke-cluster-1",
    env  = var.environment
  }

  master_authorized_networks = [
    {
      cidr_block   = "${var.external_subnet_cidr}"
      display_name = "BastionServer"
    },
    {
      cidr_block   = "${var.nat_ip}"
      display_name = "ArgoCD NAT"
    },
    {
      cidr_block   = "34.68.239.28/32"
      display_name = "Dev NAT IP"
    },
  ]
  node_pools = [
    {
      name            = "generic-compute"
      machine_type    = var.node_type
      autoscaling     = true
      min_count       = var.node_min_count
      max_count       = var.node_max_count
      disk_size_gb    = 64
      disk_type       = "pd-ssd"
      image_type      = "COS_CONTAINERD"
      auto_upgrade    = true
      auto_repair     = true
      service_account = var.sa_gke
    },
    {
      name            = "generic-clinician"
      machine_type    = var.dc_node_type
      autoscaling     = true
      min_count       = var.dc_node_min_count
      max_count       = var.dc_node_max_count
      disk_size_gb    = 64
      node_locations  = var.node_locations
      disk_type       = "pd-ssd"
      image_type      = "COS_CONTAINERD"
      auto_upgrade    = true
      auto_repair     = true
      service_account = var.sa_gke
    },


  ]
  node_pools_labels = {
    generic-clinician = {
      app = "gc"
    }
  }

}



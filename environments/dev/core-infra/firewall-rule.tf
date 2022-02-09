module "firewall_rules_web" {
  source       = "../../../shared-modules/gcp-firewall-rules"
  project_id   = var.project_id
  network_name = module.vpc.network_name

  rules = [{
    name                    = "incomming-proxy-ssh-to-jump"
    description             = null
    direction               = "INGRESS"
    priority                = null
    ranges                  = ["35.235.240.0/20"]
    source_tags             = null
    source_service_accounts = null
    target_tags             = ["${var.prefix}-bastion-template"]
    target_service_accounts = null
    allow = [{
      protocol = "tcp"
      ports    = ["22","9000"]
    }]
    deny = []
    log_config = {
      metadata = "INCLUDE_ALL_METADATA"
    }
    }
  ]
}

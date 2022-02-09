module "redis" {
  source = "../../../shared-modules/gcp-redis"
  tier   = var.tier
  redis_name = "${var.prefix}-redis-instance"
  project_id = var.project_id
  mem_size = var.mem_size
  redis_version = var.redis_version
  authorized_network = "${var.prefix}-vpc"
  location_id        = var.location_id
  region             = var.region
  display_name       = var.redis_display_name
  prefix             = var.prefix

}
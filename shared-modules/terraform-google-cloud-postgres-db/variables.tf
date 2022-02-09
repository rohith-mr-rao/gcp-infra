# ---------------------------------------------------------------------------------------------------------------------
# REQUIRED PARAMETERS
# These variables are expected to be passed in by the operator
# ---------------------------------------------------------------------------------------------------------------------

variable "project_id" {
  description = "The project ID to host the database in."
  type        = string
}

variable "region" {
  description = "The region to host the database in."
  type        = string
}
variable "db_name" {
  description = "The name of the database instance. Note, after a name is used, it cannot be reused for up to one week. Use lowercase letters, numbers, and hyphens. Start with a letter."
  type        = string
}

# ---------------------------------------------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
# Generally, these values won't need to be changed.
# ---------------------------------------------------------------------------------------------------------------------

variable "activation_policy" {
  description = "This specifies when the instance should be active. Can be either `ALWAYS`, `NEVER` or `ON_DEMAND`."
  type        = string
  default     = "ALWAYS"
}

variable "authorized_networks" {
  description = "A list of authorized CIDR-formatted IP address ranges that can connect to this DB. Only applies to public IP instances."
  type        = list(map(string))
  default     = []
}

variable "backup_enabled" {
  description = "Set to false if you want to disable backup."
  type        = bool
  default     = true
}

variable "backup_start_time" {
  description = "HH:MM format (e.g. 04:00) time indicating when backup configuration starts. NOTE: Start time is randomly assigned if backup is enabled and 'backup_start_time' is not set"
  type        = string
  default     = "04:00"
}

variable "postgres_point_in_time_recovery_enabled" {
  description = "Will restart database if enabled after instance creation - only applicable to PostgreSQL"
  type        = bool
  default     = false
}

variable "mysql_binary_log_enabled" {
  description = "Set to false if you want to disable binary logs - only applicable to MySQL. Note, when using failover or read replicas, master and existing backups need to have binary_log_enabled=true set."
  type        = bool
  default     = true
}

variable "maintenance_window_day" {
  description = "Day of week (1-7), starting on Monday, on which system maintenance can occur. Performance may be degraded or there may even be a downtime during maintenance windows."
  type        = number
  default     = 7
}

variable "maintenance_window_hour" {
  description = "Hour of day (0-23) on which system maintenance can occur. Ignored if 'maintenance_window_day' not set. Performance may be degraded or there may even be a downtime during maintenance windows."
  type        = number
  default     = 7
}

variable "maintenance_track" {
  description = "Receive updates earlier (canary) or later (stable)."
  type        = string
  default     = "stable"
}

variable "db_charset" {
  description = "The charset for the default database."
  type        = string
  default     = null
}

variable "db_collation" {
  description = "The collation for the default database. Example for MySQL databases: 'utf8_general_ci'."
  type        = string
  default     = null
}

variable "database_flags" {
  description = "List of Cloud SQL flags that are applied to the database server"
  type        = list(any)
  default     = []
}

variable "disk_autoresize" {
  description = "Second Generation only. Configuration to increase storage size automatically."
  type        = bool
  default     = true
}

variable "disk_size" {
  description = "Second generation only. The size of data disk, in GB. Size of a running instance cannot be reduced but can be increased."
  type        = number
  default     = 10
}

variable "disk_type" {
  description = "The type of storage to use. Must be one of `PD_SSD` or `PD_HDD`."
  type        = string
  default     = "PD_SSD"
}

variable "master_zone" {
  description = "Preferred zone for the master instance (e.g. 'us-central1-a'). 'region'. If null, Google will auto-assign a zone."
  type        = string
  default     = null
}

variable "master_user_host" {
  description = "The host part for the default user, i.e. 'master_user_name'@'master_user_host' IDENTIFIED BY 'master_user_password'. Don't set this field for Postgres instances."
  type        = string
  default     = "%"
}

# In nearly all cases, databases should NOT be publicly accessible, however if you're migrating from a PAAS provider like Heroku to GCP, this needs to remain open to the internet.
variable "enable_public_internet_access" {
  description = "WARNING: - In nearly all cases a database should NOT be publicly accessible. Only set this to true if you want the database open to the internet."
  type        = bool
  default     = false
}

variable "require_ssl" {
  description = "True if the instance should require SSL/TLS for users connecting over IP. Note: SSL/TLS is needed to provide security when you connect to Cloud SQL using IP addresses. If you are connecting to your instance only by using the Cloud SQL Proxy or the Java Socket Library, you do not need to configure your instance to use SSL/TLS."
  type        = bool
  default     = true
}

variable "private_network" {
  description = "The resource link for the VPC network from which the Cloud SQL instance is accessible for private IP."
  type        = string
  default     = null
}

variable "num_read_replicas" {
  description = "The number of read replicas to create. Cloud SQL will replicate all data from the master to these replicas, which you can use to horizontally scale read traffic."
  type        = number
  default     = 0
}

variable "read_replica_zones" {
  description = "A list of compute zones where read replicas should be created. List size should match 'num_read_replicas'"
  type        = list(string)
  default     = []
}

variable "custom_labels" {
  description = "A map of custom labels to apply to the instance. The key is the label name and the value is the label value."
  type        = map(string)
  default     = {}
}

# Resources are created sequentially. Therefore we increase the default timeouts considerably
# to not have the operations time out.
variable "resource_timeout" {
  description = "Timeout for creating, updating and deleting database instances. Valid units of time are s, m, h."
  type        = string
  default     = "60m"
}

# Whether or not to allow Terraform to destroy the instance.
variable "deletion_protection" {
  description = "Whether or not to allow Terraform to destroy the instance. Unless this field is set to false in Terraform state, a terraform destroy or terraform apply command that deletes the instance will fail."
  type        = bool
}

# ---------------------------------------------------------------------------------------------------------------------
# MODULE DEPENDENCIES
# Workaround Terraform limitation where there is no module depends_on.
# See https://github.com/hashicorp/terraform/issues/1178 for more details.
# This can be used to make sure the module resources are created after other bootstrapping resources have been created.
# For example:
# dependencies = [google_service_networking_connection.private_vpc_connection.network]
# ---------------------------------------------------------------------------------------------------------------------

variable "dependencies" {
  description = "Create a dependency between the resources in this module to the interpolated values in this list (and thus the source resources). In other words, the resources in this module will now depend on the resources backing the values in this list such that those resources need to be created before the resources in this module, and the resources in this module need to be destroyed before the resources in the list."
  type        = list(string)
  default     = []
}

variable "user_password" {
  description = "The password for the default user. If not set, a random one will be generated and available in the generated_user_password output variable."
  type        = string
  default     = ""
}
variable "random_instance_name" {
  type        = bool
  description = "Sets random suffix at the end of the Cloud SQL resource name"
  default     = false
}

variable "database_version" {
  description = "The database version to use"
  type        = string
}
variable "encryption_key_name" {
  description = "The full path to the encryption key used for the CMEK disk encryption"
  type        = string
  default     = null
}
variable "tier" {
  description = "The tier for the master instance."
  type        = string
  default     = "db-f1-micro"
}

variable "availability_type" {
  description = "The availability type for the master instance.This is only used to set up high availability for the PostgreSQL instance. Can be either `ZONAL` or `REGIONAL`."
  type        = string
  default     = "ZONAL"
}
variable "backup_configuration" {
  description = "The backup_configuration settings subblock for the database setings"
  type = object({
    enabled                        = bool
    start_time                     = string
    location                       = string
    point_in_time_recovery_enabled = bool
    transaction_log_retention_days = string
    retained_backups               = number
    retention_unit                 = string
  })
  default = {
    enabled                        = true
    start_time                     = null
    location                       = null
    point_in_time_recovery_enabled = true
    transaction_log_retention_days = null
    retained_backups               = null
    retention_unit                 = null
  }
}
variable "insights_config" {
  description = "The insights_config settings for the database."
  type = object({
    query_string_length     = number
    record_application_tags = bool
    record_client_address   = bool
  })
  default = null
}
variable "pricing_plan" {
  description = "The pricing plan for the master instance."
  type        = string
  default     = "PER_USE"
}
variable "user_labels" {
  description = "The key/value labels for the master instances."
  type        = map(string)
  default     = {}
}
variable "zone" {
  type        = string
  description = "The zone for the master instance, it should be something like: `us-central1-a`, `us-east1-c`."
}
variable "maintenance_window_update_track" {
  description = "The update track of maintenance window for the master instance maintenance.Can be either `canary` or `stable`."
  type        = string
  default     = "canary"
}
variable "create_timeout" {
  description = "The optional timout that is applied to limit long database creates."
  type        = string
  default     = "15m"
}
variable "update_timeout" {
  description = "The optional timout that is applied to limit long database updates."
  type        = string
  default     = "15m"
}

variable "ip_configuration" {
  description = "The ip configuration for the master instances."
  type = object({
    authorized_networks = list(map(string))
    ipv4_enabled        = bool
    private_network     = string
    require_ssl         = bool
  })
  default = {
    authorized_networks = []
    ipv4_enabled        = true
    private_network     = null
    require_ssl         = null
  }
}

variable "delete_timeout" {
  description = "The optional timout that is applied to limit long database deletes."
  type        = string
  default     = "15m"
}
variable "module_depends_on" {
  description = "List of modules or resources this module depends on."
  type        = list(any)
  default     = []
}
variable "enable_default_db" {
  description = "Enable or disable the creation of the default database"
  type        = bool
  default     = true
}
variable "enable_default_user" {
  description = "Enable or disable the creation of the default user"
  type        = bool
  default     = true
}
variable "user_name" {
  description = "The name of the default user"
  type        = string
  default     = "default"
}
variable "network_name" {
  description = "Name of the network"
}

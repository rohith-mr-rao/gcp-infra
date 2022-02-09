
variable "project" {
  type = string
  default = ""
}
variable "region" {
  type = string
  default = ""
}
variable "zone" {
  type = string
  default = ""
}

variable "name" {
  type = string
  default = ""
}
variable "branch_name" {
  type = string
  default = ""
} 

variable "repo_owner" {
  type = string
  default = ""
}

variable "repo_name" {
  type = string
  default = ""
}
variable "v1" {
  type = string
  description = "values for env variable"
  default = ""
}
variable "v2" {
  type = string
  description = "values for env variable"
  default = ""
}
variable "v3" {
  type = string
  description = "values for env variable"
  default = ""
}
variable "v4" {
  type = string
  description = "values for env variable"
  default = ""
}
variable "filename" {
  type = string
  description = "cloudbuild.yaml file name"
  default = ""
}
variable "_VAR1" {
  type = string
  description = "variable name for cloud build"
  default = ""
}
variable "_VAR2" {
  type = string
  description = "variable name for cloud build"
  default = ""
}
variable "_VAR3" {
  type = string
  description = "variable name for cloud build"
  default = ""
}
variable "_VAR4" {
  type = string
  description = "variable name for cloud build"
  default = ""
}
variable "_SONAR_INSTANCE" {
  type = string
  description = "sonar instance name"
  default = ""
}
variable "_PROJECT" {
  type = string
  description = "sonar instance project name"
  default = ""
}
variable "_SONAR_INSTANCE_ZONE" {
  type = string
  description = "sonar instance zone"
  default = ""
}
variable "sonar_instance_name" {
  type = string
  description = "name of sonar instance"
  default = ""
}
variable "project_name" {
  type = string
  description = "project name of sonar instance"
  default = ""
}
variable "sonar_instance_zone" {
  type = string
  description = "zone of sonar instance"
  default = ""
}
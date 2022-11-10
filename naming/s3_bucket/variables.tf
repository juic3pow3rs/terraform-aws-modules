variable "environment" {
  description = "Environment to deploy resources, e.g. 'prod', or 'dev'"
  type        = string
}

variable "role" {
  description = "Role or Scope of the Service, e.g. 'ldap' or application name like 'jenkins'"
  type        = string
}

variable "team" {
  description = "Project or Team"
  type        = string
  default     = "db-service-team"
}

variable "team_shortname" {
  description = "The short name of the team responsilbe for the resource deployment"
  type        = string
  default     = "dbs"
}

variable "resource_shortname" {
  description = "The short name of the resource deployed"
  type        = string
  default     = "s3b"
}

variable "prefix" {
  description = "Defined prefix for all services in cloudops"
  type        = string
  default     = "azd-service-dbs"
}

variable "override_bucket_name" {
  description = "Override the Bucket name with a specific string, defaults to null"
  type        = string
  default     = null
}

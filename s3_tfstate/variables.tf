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
  default     = "andi"
}

variable "team_shortname" {
  description = "The short name of the team responsilbe for the resource deployment"
  type        = string
  default     = "aiml"
}

variable "resource_shortname" {
  description = "The short name of the resource deployed"
  type        = string
  default     = "s3"
}

variable "s3_bucket_versioning" {
  default     = true
  description = "true/false for if versioning should be enabled"
}

variable "template_version" {
  description = "Template version used to create the resources"
  type        = string
  default     = "v0.0.1"
}

variable "bcm" {
  description = "Categoration of the database is bcm relevant"
  type        = string
  default     = "no"
}

variable "override_bucket_name" {
  default = null 
}
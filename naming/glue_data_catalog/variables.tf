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
  default     = "gl_cat"
}

variable "prefix" {
  description = "Defined prefix for all services"
  type        = string
  default     = "uni"
}

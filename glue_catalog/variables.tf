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
  default     = "lf"
}

variable "project" {
  description = "Customer or project name."
  type        = string
  default     = "ws2223"
}

variable "template_version" {
  description = "Template version used to create the resources"
  type        = string
  default     = "v0.0.1"
}

variable "s3_bucket_name" {
  type        = string
  description = "Name of S3 Bucket"
}

variable "folder_path" {
  type        = string
  description = "Path of file"
}


variable "file_name" {
  type        = string
  description = "Filename of which to upload"
}


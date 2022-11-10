output "bucket_name" {
  value = var.override_bucket_name == null ? "${var.prefix}-${var.team_shortname}-${var.resource_shortname}-${var.role}-${var.environment}" : var.override_bucket_name
}

output "sagemaker_name" {
  value = "${var.prefix}-${var.team_shortname}-${var.resource_shortname}-${var.role}-${var.environment}"
}

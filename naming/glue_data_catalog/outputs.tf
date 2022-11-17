output "catalog_db" {
  value = "${var.prefix}-${var.team_shortname}-${var.resource_shortname}-${var.role}-${var.environment}-db"
}

output "catalog_crawler" {
  value = "${var.prefix}-${var.team_shortname}-${var.resource_shortname}-${var.role}-${var.environment}-crawler"
}
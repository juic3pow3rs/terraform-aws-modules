module "naming" {
  source             = "../naming/s3"
  environment        = var.environment
  role               = var.role
  team               = var.team
  team_shortname     = var.team_shortname
  resource_shortname = var.resource_shortname
  override_bucket_name = var.override_bucket_name
}

resource "aws_s3_bucket" "bucket" {
  bucket = module.naming.bucket-name

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  versioning {
    enabled = var.s3_bucket_versioning
  }

  tags = {
    Name            = module.naming.bucket-name
    Environment     = var.environment
    Project         = var.project
    TemplateVersion = var.template_version
    ManagedBy       = var.team
  }
}

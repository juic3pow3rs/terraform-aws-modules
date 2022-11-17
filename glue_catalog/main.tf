module "naming" {
  source               = "../naming/glue_data_catalog"
  environment          = var.environment
  role                 = var.role
  team                 = var.team
  team_shortname       = var.team_shortname
  resource_shortname   = var.resource_shortname
}

resource "aws_iam_role" "glue" {
  name = "AWSGlueServiceRoleDefault"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "glue.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "glue_service" {
    role = aws_iam_role.glue.id
    policy_arn = "arn:aws:iam::aws:policy/service-role/AWSGlueServiceRole"
}

resource "aws_glue_catalog_database" "aws_glue_catalog_database" {
  name = module.naming.catalog_db
  location_uri = "s3://${var.s3_bucket_name}/${var.folder_path}" #s3://uni-aiml-s3-cloud01-dev/bronze/ingestion
}

resource "aws_lakeformation_permissions" "database" {
  principal   = aws_iam_role.glue.arn
  permissions = ["CREATE_TABLE", "ALTER", "DESCRIBE"]

  database {
    name       = module.naming.catalog_db
  }
}

resource "aws_glue_crawler" "example" {
  database_name = module.naming.catalog_db
  name          = module.naming.catalog_crawler
  role          = aws_iam_role.glue.arn

  s3_target {
    path = "s3://${var.s3_bucket_name}/${var.folder_path}/${var.file_name}"
  }
}


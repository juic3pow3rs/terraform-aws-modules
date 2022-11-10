resource "aws_lakeformation_data_lake_settings" "admin" {
  admins = [var.admin_user_arn]
}

resource "aws_lakeformation_data_lake_settings" "admin_permission" {
  admins = [var.admin_user_arn]

  create_database_default_permissions {
    permissions = ["ALL"]
    principal   = var.admin_user_arn
  }

  create_table_default_permissions {
    permissions = ["ALL"]
    principal   = var.admin_user_arn
  }
}

resource "aws_iam_service_linked_role" "lakeformation" {
  aws_service_name = "lakeformation.amazonaws.com"
}

resource "aws_lakeformation_resource" "data_lake" {
  arn = var.s3_bucket_arn
}

resource "aws_s3_object" "bronze_folder" {
  bucket = var.s3_bucket_name
  key    =  "bronze/"
  content_type = "application/x-directory"
}

resource "aws_s3_object" "silver_folder" {
  bucket = var.s3_bucket_name
  key    =  "bronze/"
  content_type = "application/x-directory"
}

resource "aws_s3_object" "gold_folder" {
  bucket = var.s3_bucket_name
  key    =  "bronze/"
  content_type = "application/x-directory"
}

resource "aws_s3_object" "datafile" {
  bucket = var.s3_bucket_name
  key    =  "bronze/ingestion/${var.file_name}"
  source = var.file_source
}


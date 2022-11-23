module "naming" {
  source             = "../naming/sagemaker"
  environment        = var.environment
  role               = var.role
  team               = var.team
  team_shortname     = var.team_shortname
  resource_shortname = var.resource_shortname
}

resource "aws_iam_role" "sagemaker" {
  name               = "AWSSageMakerServiceRoleUni"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "sagemaker.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "AmazonSageMakerFullAccess" {
  role       = aws_iam_role.sagemaker.id
  policy_arn = "arn:aws:iam::aws:policy/AmazonSageMakerFullAccess"
}

resource "aws_iam_role_policy_attachment" "AmazonS3FullAccess" {
  role       = aws_iam_role.sagemaker.id
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

resource "aws_s3_object" "datafile" {
  bucket = var.s3_bucket_name
  key    = var.file_name
  source = var.file_source
}

resource "aws_sagemaker_code_repository" "uebung" {
  code_repository_name = "uebung-notebooks"

  git_config {
    repository_url = "https://github.com/juic3pow3rs/terraform-aws-sagemaker-notebook.git"
  }
}

resource "aws_sagemaker_notebook_instance" "uebung01" {
  name          = module.naming.sagemaker_name
  role_arn      = aws_iam_role.sagemaker.arn
  instance_type = "ml.t3.medium"
  default_code_repository = aws_sagemaker_code_repository.uebung.code_repository_name
}

module "naming" {
  source               = "../naming/glue_data_catalog"
  environment          = var.environment
  role                 = var.role
  team                 = var.team
  team_shortname       = var.team_shortname
  resource_shortname   = var.resource_shortname
}

resource "aws_iam_role" "glue" {
  name = "AWSGlueServiceRoleUni"
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

resource "aws_iam_policy" "glue_crawler_policy" {
  name        = "AWSGlueCrawlerPolicy"
  path        = "/"
  description = "Policy for AWS Glue Crawler"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
        {
            "Effect": "Allow",
            "Action": [
                "glue:*",
                "s3:GetBucketLocation",
                "s3:ListBucket",
                "s3:ListAllMyBuckets",
                "s3:GetBucketAcl",
                "ec2:DescribeVpcEndpoints",
                "ec2:DescribeRouteTables",
                "ec2:CreateNetworkInterface",
                "ec2:DeleteNetworkInterface",
                "ec2:DescribeNetworkInterfaces",
                "ec2:DescribeSecurityGroups",
                "ec2:DescribeSubnets",
                "ec2:DescribeVpcAttribute",
                "iam:ListRolePolicies",
                "iam:GetRole",
                "iam:GetRolePolicy",
                "cloudwatch:PutMetricData"
            ],
            "Resource": [
                "*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "s3:CreateBucket"
            ],
            "Resource": [
                "arn:aws:s3:::*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "s3:GetObject",
                "s3:PutObject",
                "s3:DeleteObject"
            ],
            "Resource": [
                "arn:aws:s3:::*/*",
                "arn:aws:s3:::*/*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "s3:GetObject"
            ],
            "Resource": [
                "arn:aws:s3:::*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "logs:CreateLogGroup",
                "logs:CreateLogStream",
                "logs:PutLogEvents"
            ],
            "Resource": [
                "arn:aws:logs:*:*:/aws-glue/*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "ec2:CreateTags",
                "ec2:DeleteTags"
            ],
            "Condition": {
                "ForAllValues:StringEquals": {
                    "aws:TagKeys": [
                        "aws-glue-service-resource"
                    ]
                }
            },
            "Resource": [
                "arn:aws:ec2:*:*:network-interface/*",
                "arn:aws:ec2:*:*:security-group/*",
                "arn:aws:ec2:*:*:instance/*"
            ]
        }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "glue_service" {
    role = aws_iam_role.glue.id
    policy_arn = aws_iam_policy.glue_crawler_policy.arn
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


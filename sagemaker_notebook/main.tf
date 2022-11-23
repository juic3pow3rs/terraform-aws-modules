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

resource "aws_iam_policy" "sagemaker_policy" {
  name        = "AWSSageMakerPolicy"
  path        = "/"
  description = "Policy for Sagemaker"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        "Effect" : "Allow",
        "Action" : [
          "sagemaker:*"
        ],
        "NotResource" : [
          "arn:aws:sagemaker:*:*:domain/*",
          "arn:aws:sagemaker:*:*:user-profile/*",
          "arn:aws:sagemaker:*:*:app/*",
          "arn:aws:sagemaker:*:*:flow-definition/*"
        ]
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "sagemaker:CreatePresignedDomainUrl",
          "sagemaker:DescribeDomain",
          "sagemaker:ListDomains",
          "sagemaker:DescribeUserProfile",
          "sagemaker:ListUserProfiles",
          "sagemaker:*App",
          "sagemaker:ListApps"
        ],
        "Resource" : "*"
      },
      {
        "Effect" : "Allow",
        "Action" : "sagemaker:*",
        "Resource" : [
          "arn:aws:sagemaker:*:*:flow-definition/*"
        ],
        "Condition" : {
          "StringEqualsIfExists" : {
            "sagemaker:WorkteamType" : [
              "private-crowd",
              "vendor-crowd"
            ]
          }
        }
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "application-autoscaling:DeleteScalingPolicy",
          "application-autoscaling:DeleteScheduledAction",
          "application-autoscaling:DeregisterScalableTarget",
          "application-autoscaling:DescribeScalableTargets",
          "application-autoscaling:DescribeScalingActivities",
          "application-autoscaling:DescribeScalingPolicies",
          "application-autoscaling:DescribeScheduledActions",
          "application-autoscaling:PutScalingPolicy",
          "application-autoscaling:PutScheduledAction",
          "application-autoscaling:RegisterScalableTarget",
          "aws-marketplace:ViewSubscriptions",
          "cloudformation:GetTemplateSummary",
          "cloudwatch:DeleteAlarms",
          "cloudwatch:DescribeAlarms",
          "cloudwatch:GetMetricData",
          "cloudwatch:GetMetricStatistics",
          "cloudwatch:ListMetrics",
          "cloudwatch:PutMetricAlarm",
          "cloudwatch:PutMetricData",
          "codecommit:BatchGetRepositories",
          "codecommit:CreateRepository",
          "codecommit:GetRepository",
          "codecommit:List*",
          "cognito-idp:AdminAddUserToGroup",
          "cognito-idp:AdminCreateUser",
          "cognito-idp:AdminDeleteUser",
          "cognito-idp:AdminDisableUser",
          "cognito-idp:AdminEnableUser",
          "cognito-idp:AdminRemoveUserFromGroup",
          "cognito-idp:CreateGroup",
          "cognito-idp:CreateUserPool",
          "cognito-idp:CreateUserPoolClient",
          "cognito-idp:CreateUserPoolDomain",
          "cognito-idp:DescribeUserPool",
          "cognito-idp:DescribeUserPoolClient",
          "cognito-idp:List*",
          "cognito-idp:UpdateUserPool",
          "cognito-idp:UpdateUserPoolClient",
          "ec2:CreateNetworkInterface",
          "ec2:CreateNetworkInterfacePermission",
          "ec2:CreateVpcEndpoint",
          "ec2:DeleteNetworkInterface",
          "ec2:DeleteNetworkInterfacePermission",
          "ec2:DescribeDhcpOptions",
          "ec2:DescribeNetworkInterfaces",
          "ec2:DescribeRouteTables",
          "ec2:DescribeSecurityGroups",
          "ec2:DescribeSubnets",
          "ec2:DescribeVpcEndpoints",
          "ec2:DescribeVpcs",
          "ecr:BatchCheckLayerAvailability",
          "ecr:BatchGetImage",
          "ecr:CreateRepository",
          "ecr:Describe*",
          "ecr:GetAuthorizationToken",
          "ecr:GetDownloadUrlForLayer",
          "ecr:StartImageScan",
          "elastic-inference:Connect",
          "elasticfilesystem:DescribeFileSystems",
          "elasticfilesystem:DescribeMountTargets",
          "fsx:DescribeFileSystems",
          "glue:CreateJob",
          "glue:DeleteJob",
          "glue:GetJob*",
          "glue:GetTable*",
          "glue:GetWorkflowRun",
          "glue:ResetJobBookmark",
          "glue:StartJobRun",
          "glue:StartWorkflowRun",
          "glue:UpdateJob",
          "groundtruthlabeling:*",
          "iam:ListRoles",
          "kms:DescribeKey",
          "kms:ListAliases",
          "lambda:ListFunctions",
          "logs:CreateLogDelivery",
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:DeleteLogDelivery",
          "logs:Describe*",
          "logs:GetLogDelivery",
          "logs:GetLogEvents",
          "logs:ListLogDeliveries",
          "logs:PutLogEvents",
          "logs:PutResourcePolicy",
          "logs:UpdateLogDelivery",
          "robomaker:CreateSimulationApplication",
          "robomaker:DescribeSimulationApplication",
          "robomaker:DeleteSimulationApplication",
          "robomaker:CreateSimulationJob",
          "robomaker:DescribeSimulationJob",
          "robomaker:CancelSimulationJob",
          "secretsmanager:ListSecrets",
          "servicecatalog:Describe*",
          "servicecatalog:List*",
          "servicecatalog:ScanProvisionedProducts",
          "servicecatalog:SearchProducts",
          "servicecatalog:SearchProvisionedProducts",
          "sns:ListTopics",
          "tag:GetResources"
        ],
        "Resource" : "*"
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "ecr:SetRepositoryPolicy",
          "ecr:CompleteLayerUpload",
          "ecr:BatchDeleteImage",
          "ecr:UploadLayerPart",
          "ecr:DeleteRepositoryPolicy",
          "ecr:InitiateLayerUpload",
          "ecr:DeleteRepository",
          "ecr:PutImage"
        ],
        "Resource" : [
          "arn:aws:ecr:*:*:repository/*sagemaker*"
        ]
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "codecommit:GitPull",
          "codecommit:GitPush"
        ],
        "Resource" : [
          "arn:aws:codecommit:*:*:*sagemaker*",
          "arn:aws:codecommit:*:*:*SageMaker*",
          "arn:aws:codecommit:*:*:*Sagemaker*"
        ]
      },
      {
        "Action" : [
          "codebuild:BatchGetBuilds",
          "codebuild:StartBuild"
        ],
        "Resource" : [
          "arn:aws:codebuild:*:*:project/sagemaker*",
          "arn:aws:codebuild:*:*:build/*"
        ],
        "Effect" : "Allow"
      },
      {
        "Action" : [
          "states:DescribeExecution",
          "states:GetExecutionHistory",
          "states:StartExecution",
          "states:StopExecution",
          "states:UpdateStateMachine"
        ],
        "Resource" : [
          "arn:aws:states:*:*:statemachine:*sagemaker*",
          "arn:aws:states:*:*:execution:*sagemaker*:*"
        ],
        "Effect" : "Allow"
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "secretsmanager:DescribeSecret",
          "secretsmanager:GetSecretValue",
          "secretsmanager:CreateSecret"
        ],
        "Resource" : [
          "arn:aws:secretsmanager:*:*:secret:AmazonSageMaker-*"
        ]
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "secretsmanager:DescribeSecret",
          "secretsmanager:GetSecretValue"
        ],
        "Resource" : "*",
        "Condition" : {
          "StringEquals" : {
            "secretsmanager:ResourceTag/SageMaker" : "true"
          }
        }
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "servicecatalog:ProvisionProduct"
        ],
        "Resource" : "*"
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "servicecatalog:TerminateProvisionedProduct",
          "servicecatalog:UpdateProvisionedProduct"
        ],
        "Resource" : "*",
        "Condition" : {
          "StringEquals" : {
            "servicecatalog:userLevel" : "self"
          }
        }
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "s3:*",
        ],
        "Resource" : [
          "arn:aws:s3:::*"
        ]
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "lambda:InvokeFunction"
        ],
        "Resource" : [
          "arn:aws:lambda:*:*:function:*SageMaker*",
          "arn:aws:lambda:*:*:function:*sagemaker*",
          "arn:aws:lambda:*:*:function:*Sagemaker*",
          "arn:aws:lambda:*:*:function:*LabelingFunction*"
        ]
      },
      {
        "Action" : "iam:CreateServiceLinkedRole",
        "Effect" : "Allow",
        "Resource" : "arn:aws:iam::*:role/aws-service-role/sagemaker.application-autoscaling.amazonaws.com/AWSServiceRoleForApplicationAutoScaling_SageMakerEndpoint",
        "Condition" : {
          "StringLike" : {
            "iam:AWSServiceName" : "sagemaker.application-autoscaling.amazonaws.com"
          }
        }
      },
      {
        "Effect" : "Allow",
        "Action" : "iam:CreateServiceLinkedRole",
        "Resource" : "*",
        "Condition" : {
          "StringEquals" : {
            "iam:AWSServiceName" : "robomaker.amazonaws.com"
          }
        }
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "sns:Subscribe",
          "sns:CreateTopic",
          "sns:Publish"
        ],
        "Resource" : [
          "arn:aws:sns:*:*:*SageMaker*",
          "arn:aws:sns:*:*:*Sagemaker*",
          "arn:aws:sns:*:*:*sagemaker*"
        ]
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "iam:PassRole"
        ],
        "Resource" : "arn:aws:iam::*:role/*AmazonSageMaker*",
        "Condition" : {
          "StringEquals" : {
            "iam:PassedToService" : [
              "glue.amazonaws.com",
              "robomaker.amazonaws.com",
              "states.amazonaws.com"
            ]
          }
        }
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "iam:PassRole"
        ],
        "Resource" : "arn:aws:iam::*:role/*",
        "Condition" : {
          "StringEquals" : {
            "iam:PassedToService" : "sagemaker.amazonaws.com"
          }
        }
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "athena:ListDataCatalogs",
          "athena:ListDatabases",
          "athena:ListTableMetadata",
          "athena:GetQueryExecution",
          "athena:GetQueryResults",
          "athena:StartQueryExecution",
          "athena:StopQueryExecution"
        ],
        "Resource" : [
          "*"
        ]
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "glue:CreateTable"
        ],
        "Resource" : [
          "arn:aws:glue:*:*:table/*/sagemaker_tmp_*",
          "arn:aws:glue:*:*:table/sagemaker_featurestore/*",
          "arn:aws:glue:*:*:catalog",
          "arn:aws:glue:*:*:database/*"
        ]
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "glue:UpdateTable"
        ],
        "Resource" : [
          "arn:aws:glue:*:*:table/sagemaker_featurestore/*",
          "arn:aws:glue:*:*:catalog",
          "arn:aws:glue:*:*:database/sagemaker_featurestore"
        ]
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "glue:DeleteTable"
        ],
        "Resource" : [
          "arn:aws:glue:*:*:table/*/sagemaker_tmp_*",
          "arn:aws:glue:*:*:catalog",
          "arn:aws:glue:*:*:database/*"
        ]
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "glue:GetDatabases",
          "glue:GetTable",
          "glue:GetTables"
        ],
        "Resource" : [
          "arn:aws:glue:*:*:table/*",
          "arn:aws:glue:*:*:catalog",
          "arn:aws:glue:*:*:database/*"
        ]
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "glue:CreateDatabase",
          "glue:GetDatabase"
        ],
        "Resource" : [
          "arn:aws:glue:*:*:catalog",
          "arn:aws:glue:*:*:database/sagemaker_featurestore",
          "arn:aws:glue:*:*:database/sagemaker_processing",
          "arn:aws:glue:*:*:database/default",
          "arn:aws:glue:*:*:database/sagemaker_data_wrangler"
        ]
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "redshift-data:ExecuteStatement",
          "redshift-data:DescribeStatement",
          "redshift-data:CancelStatement",
          "redshift-data:GetStatementResult",
          "redshift-data:ListSchemas",
          "redshift-data:ListTables"
        ],
        "Resource" : [
          "*"
        ]
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "redshift:GetClusterCredentials"
        ],
        "Resource" : [
          "arn:aws:redshift:*:*:dbuser:*/sagemaker_access*",
          "arn:aws:redshift:*:*:dbname:*"
        ]
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "cloudformation:ListStackResources"
        ],
        "Resource" : "arn:aws:cloudformation:*:*:stack/SC-*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "sagemaker" {
  role       = aws_iam_service_linked_role.sagemaker.id
  policy_arn = aws_iam_policy.sagemaker_policy.arn
}

resource "aws_s3_object" "datafile" {
  bucket = var.s3_bucket_name
  key    = var.file_name
  source = var.file_source
}

resource "aws_sagemaker_notebook_instance" "uebung01" {
  name          = module.naming.sagemaker_name
  role_arn      = aws_iam_service_linked_role.sagemaker.arn
  instance_type = "ml.t3.medium"
}

# terraform-aws-modules

This repository contains the terraform modules used for all aws resources used in the AI & ML Masters course at University of Leipzig.

Provider needs to be specified in a separate .tf-file and referenced in the module call like this (alias in this case is ffm):
```hcl
providers = {
  aws = aws.ffm
}
```

## Minimum required versions

The minimum required versions of Terraform and AWS (in this case) provider version are defined in each submodule wherever necessary in versions.tf file.

Current minimum required versions are:
* **Terraform** - v1.3.0
* **AWS provider** - v4.38

## Add Submodule

First create a directory to start using the modules.

Add the submodules:

``` git submodule add https://github.com/juic3pow3rs/terraform-aws-modules.git```

Create a main.tf and start using the modules.
Example:

```hcl
module "<module-name>" {
  source                = "./terraform-aws-modules/<module>"
  .
  .
  .
}
```

## Setup Locals
We use locals in terraform for setting up the input variables. There are multiple ways for doing this so take this just as an advise. If you do it different it still can be fine.

```hcl
locals {
  location         = "eu-central-1"
  environment      = "dev"
  project          = "ws2223"
  template_version = "0.0.1"
  team             = "andizzo"
  role             = "cloud02"
}
```

## Modules
The next part will present the modules and how they can be used.
The modules will create a ressource in your account. Be carefull to create a ressouces in your account because it will probably charge you money.

### Examples

<details>
  <summary>s3</summary>
  Creates an s3-bucket.
  
```hcl
module "s3_bucket" {
  source = "./terraform-aws-modules/s3"
  providers = {
    aws = aws.ffm
  }

  environment      = local.environment
  role             = local.role
  template_version = local.template_version
  team             = local.team
}
```
</details>

<details>
  <summary>lake_formation</summary>
  Creates an lake formation admin, a service-linked role, registers an s3 bucket as resource and fills that bucket with some folders and a file.
  
```hcl
module "lakeformation" {
  source = "./terraform-aws-modules/lake_formation"
  providers = {
    aws = aws.ffm
  }

  admin_user_arn = data.aws_caller_identity.current.arn
  s3_bucket_arn  = module.s3_bucket.bucket_arn
  s3_bucket_name = module.s3_bucket.bucket_name
  file_name      = "demoLakeData.csv"
  file_source    = "./demoLakeData.csv"

  environment      = local.environment
  role             = local.role
  project          = local.project
  template_version = local.template_version
  team             = local.team
}
```
</details>

<details>
  <summary>glue_catalog</summary>
  Creates an glue catalog database, an glue crawler and an IAM role which the glue service can assume as well as setting lake formation permission for that role
  
```hcl
module "glue_catalog" {
  source = "./terraform-aws-modules/glue_catalog"
  providers = {
    aws = aws.ffm
  }

  s3_bucket_name = module.s3_bucket.bucket_name
  file_name      = "demoLakeData.csv"
  folder_path    = "bronze/ingestion"

  environment      = local.environment
  role             = local.role
  project          = local.project
  template_version = local.template_version
  team             = local.team
}
```
</details>

<details>
  <summary>sagemaker_notebook</summary>
  Creates a sagemaker notebook instance with a s3 bucket as data source and a github repository for storing your jupyter notebooks.
  
```hcl
module "sagemaker_notebook" {
  source = "./terraform-aws-modules/sagemaker_notebook"
  providers = {
    aws = aws.ffm
  }

  s3_bucket_name = module.s3_bucket.bucket_name
  file_name      = "picture.png"
  file_source    = "./picture.png"
  repository_url = "https://github.com/juic3pow3rs/terraform-aws-sagemaker-notebook.git"

  environment      = local.environment
  role             = local.role
  project          = local.project
  template_version = local.template_version
  team             = local.team
}
```
</details>

## Naming Convention

Modules with an identifier are modeled around having a naming module. Naming modules can be found in the naming directory.

```${var.prefix}-${var.team_shortname}-${var.resource_shortname}-${var.role}-${var.environment}```

* **team** - The short name of the team responsilbe for the resource deployment
* **location** - Region where the service is deployed in
* **role** - Role or Scope of the Service, e.g. 'ldap' or application name like 'jenkins'
* **environment** - Environment to deploy resources, e.g. 'prod', or 'dev'
* **prefix** - uni (default)
* **team_shortname** - aiml (change to shortname of the team)

* **resource_shortname** - short name for the service <details>
  <summary>default shortnames</summary>
  
  module | shortname 
  ------------ | -------------
s3 | s3
lake_formateion | lf
glue_catalog | gl_cat
sagemaker | sgm

</details>

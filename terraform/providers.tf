provider "aws" {
  allowed_account_ids     = var.allowed_account_ids
  profile                 = var.aws_profile
  region                  = var.aws_region
  skip_metadata_api_check = var.skip_metadata_api_check

  default_tags {
    tags = {
      environment = var.environment
      managedBy   = "terraform"
      project     = "platform"
    }
  }

  endpoints {
    ec2   = var.aws_endpoint_url
    eks   = var.aws_endpoint_url
    elbv2 = var.aws_endpoint_url
    iam   = var.aws_endpoint_url
    sts   = var.aws_endpoint_url
  }
}

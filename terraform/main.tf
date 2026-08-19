module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "6.6.1"

  name            = var.eks_cluster_name
  cidr            = var.vpc_cidr_block
  azs             = var.availability_zones
  private_subnets = var.vpc_private_subnet_cidrs

  create_egress_only_igw        = false
  create_igw                    = false
  enable_nat_gateway            = false
  manage_default_network_acl    = false
  manage_default_route_table    = false
  manage_default_security_group = false

}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "21.24.0"

  kubernetes_version = var.kubernetes_version
  name               = var.eks_cluster_name
  subnet_ids         = module.vpc.private_subnets
  vpc_id             = module.vpc.vpc_id

  access_entries                     = {}
  addons                             = {}
  attach_encryption_policy           = false
  create_cloudwatch_log_group        = false
  create_kms_key                     = false
  create_node_iam_role               = false
  create_node_security_group         = false
  create_primary_security_group_tags = false
  create_security_group              = false
  dataplane_wait_duration            = "0s"
  eks_managed_node_groups            = {}
  enable_irsa                        = var.eks_enable_irsa
  enabled_log_types                  = []
  encryption_config                  = null
  endpoint_private_access            = var.eks_endpoint_private_access
  endpoint_public_access             = var.eks_endpoint_public_access
  fargate_profiles                   = {}
  identity_providers                 = {}
  self_managed_node_groups           = {}
}

module "nlb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "10.5.0"

  name               = "${var.eks_cluster_name}-ingress"
  load_balancer_type = "network"
  subnets            = module.vpc.private_subnets
  vpc_id             = module.vpc.vpc_id

  create_security_group            = false
  enable_cross_zone_load_balancing = false
  enable_deletion_protection       = false

  listeners = {
    ingress = {
      port     = var.ingress_listener_port
      protocol = "TCP"
      forward = {
        target_group_key = "envoy_gateway"
      }
    }
  }

  target_groups = {
    envoy_gateway = {
      name        = "${var.eks_cluster_name}-envoy"
      port        = var.ingress_node_port
      protocol    = "TCP"
      target_type = "instance"
      target_id   = var.ingress_target_id

      health_check = {
        healthy_threshold   = 5
        matcher             = "200"
        path                = "/ready"
        protocol            = "HTTP"
        unhealthy_threshold = 2
      }
    }
  }
}

resource "terraform_data" "floci_nlb_host_header" {
  count = var.enable_floci_nlb_host_preservation ? 1 : 0

  triggers_replace = [module.nlb.arn]

  provisioner "local-exec" {
    command = <<-EOT
      set -euo pipefail

      aws --no-cli-pager \
        --profile "$AWS_PROFILE" \
        --region "$AWS_REGION" \
        --endpoint-url "$AWS_ENDPOINT_URL" \
        elbv2 modify-load-balancer-attributes \
        --load-balancer-arn "$LOAD_BALANCER_ARN" \
        --attributes "Key=routing.http.preserve_host_header.enabled,Value=true" \
        --output json >/dev/null

      actual="$(
        aws --no-cli-pager \
          --profile "$AWS_PROFILE" \
          --region "$AWS_REGION" \
          --endpoint-url "$AWS_ENDPOINT_URL" \
          elbv2 describe-load-balancer-attributes \
          --load-balancer-arn "$LOAD_BALANCER_ARN" \
          --query "Attributes[?Key=='routing.http.preserve_host_header.enabled'].Value | [0]" \
          --output text
      )"
      [[ "$actual" == "true" ]]
    EOT

    environment = {
      AWS_ENDPOINT_URL  = coalesce(var.aws_endpoint_url, "")
      AWS_PROFILE       = coalesce(var.aws_profile, "")
      AWS_REGION        = var.aws_region
      LOAD_BALANCER_ARN = module.nlb.arn
    }

    interpreter = ["/usr/bin/env", "bash", "-c"]
  }
}

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

variable "allowed_account_ids" {
  description = "AWS account IDs that this environment may manage"
  type        = list(string)
  nullable    = false

  validation {
    condition     = length(var.allowed_account_ids) > 0
    error_message = "At least one allowed AWS account ID is required."
  }
}

variable "availability_zones" {
  description = "Availability zones used by the EKS control-plane subnets"
  type        = list(string)
  nullable    = false

  validation {
    condition     = length(distinct(var.availability_zones)) >= 2
    error_message = "EKS requires subnets in at least two distinct availability zones."
  }
}

variable "aws_endpoint_url" {
  description = "Optional base URL for AWS-compatible service endpoints"
  type        = string
  default     = null
}

variable "aws_profile" {
  description = "Optional shared AWS profile used by the provider"
  type        = string
  default     = null
}

variable "aws_region" {
  description = "AWS region for the platform resources"
  type        = string
  nullable    = false
}

variable "eks_cluster_name" {
  description = "EKS cluster name"
  type        = string
  default     = "platform"
  nullable    = false
}

variable "eks_enable_irsa" {
  description = "Whether the EKS module creates an IAM OIDC provider for IRSA"
  type        = bool
  default     = true
  nullable    = false
}

variable "eks_endpoint_private_access" {
  description = "Whether the EKS private API endpoint is enabled"
  type        = bool
  nullable    = false
}

variable "eks_endpoint_public_access" {
  description = "Whether the EKS public API endpoint is enabled"
  type        = bool
  nullable    = false
}

variable "environment" {
  description = "Environment name used for resource names and tags"
  type        = string
  nullable    = false
}

variable "ingress_listener_port" {
  description = "NLB listener port for ingress traffic"
  type        = number
  nullable    = false

  validation {
    condition     = var.ingress_listener_port >= 1 && var.ingress_listener_port <= 65535
    error_message = "Ingress listener port must be between 1 and 65535."
  }
}

variable "ingress_node_port" {
  description = "Kubernetes NodePort targeted by the NLB target group"
  type        = number
  nullable    = false

  validation {
    condition     = var.ingress_node_port >= 1 && var.ingress_node_port <= 65535
    error_message = "Ingress node port must be a valid TCP port between 1 and 65535."
  }
}

variable "ingress_target_id" {
  description = "Target ID registered with the ingress NLB target group"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.ingress_target_id)) > 0
    error_message = "Ingress target ID must not be blank."
  }
}

variable "kubernetes_version" {
  description = "Optional Kubernetes control-plane version"
  type        = string
  default     = null
}

variable "vpc_private_subnet_cidrs" {
  description = "CIDR blocks for the EKS control-plane subnets"
  type        = list(string)
  nullable    = false

  validation {
    condition     = length(var.vpc_private_subnet_cidrs) >= 2
    error_message = "At least two subnet CIDRs are required."
  }
}

variable "skip_metadata_api_check" {
  description = "Whether the provider skips EC2 metadata probing"
  type        = bool
  default     = false
  nullable    = false
}

variable "vpc_cidr_block" {
  description = "CIDR block for the platform VPC"
  type        = string
  nullable    = false
}
